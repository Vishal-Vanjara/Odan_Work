import '../model/user_model.dart';
import '../service/user_api_service.dart';

class UserRepository {
  final UserApiService apiService;

  UserRepository(this.apiService);

  Future<List<UserModel>> getUsers() {
    return apiService.fetchUsers();
  }
}
