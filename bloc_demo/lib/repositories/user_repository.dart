class UserRepository {
  // Simulate a login API call
  Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 2)); // simulate network delay

    // Simple fake validation
    if (username == 'user' && password == 'password') {
      return true;
    }
    return false;
  }
}
