import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/users_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// REGISTER USER
  Future<UserModel> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    // 1️⃣ Create user in Firebase Auth
    final UserCredential credential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);

    final User user = credential.user!;

    // 2️⃣ Create UserModel
    final UserModel userModel = UserModel(
      id: user.uid,
      email: user.email!,
      displayName: displayName,
      photoURL: user.photoURL ?? '',
      isOnline: true,
      lastSeen: DateTime.now(),
      createdAt: DateTime.now(),
    );

    // 3️⃣ Save to Firestore
    await _firestore.collection('users').doc(user.uid).set(userModel.toMap());

    return userModel;
  }

  /// LOGIN USER
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // 1️⃣ Sign in
    final UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final String uid = credential.user!.uid;

    // 2️⃣ Update online status
    await _firestore.collection('users').doc(uid).update({
      'isOnline': true,
      'lastSeen': Timestamp.now(),
    });

    // 3️⃣ Fetch user from Firestore
    final DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  /// LOGOUT USER
  Future<void> logout() async {
    final String uid = _auth.currentUser!.uid;

    await _firestore.collection('users').doc(uid).update({
      'isOnline': false,
      'lastSeen': Timestamp.now(),
    });

    await _auth.signOut();
  }

  /// GET CURRENT LOGGED-IN USER
  Future<UserModel?> getCurrentUser() async {
    final User? user = _auth.currentUser;
    if (user == null) return null;

    final DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) return null;

    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  /// CHANGE PASSWORD (with re-authentication)
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final User? user = _auth.currentUser;

    if (user == null || user.email == null) {
      throw FirebaseAuthException(
        code: 'no-user',
        message: 'No authenticated user found',
      );
    }

    /// Re-authebticate user with old  password
    final AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: oldPassword,
    );

    await user.reauthenticateWithCredential(credential);

    /// Update password
    await user.updatePassword(newPassword);
  }

  /// Delete Account (with re-authentication)
  Future<void> deleteAccount({required String password}) async {
    final User? user = _auth.currentUser;

    if (user == null || user.email == null) {
      throw FirebaseAuthException(
        code: 'no-user',
        message: 'no authenticated user found',
      );
    }

    /// Re-authenticate
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    await user.reauthenticateWithCredential(credential);
    /// Delete user data from firestore
    await _firestore.collection('users').doc(user.uid).delete();
    /// Delete firebase Auth account
    await user.delete();
  }
}
