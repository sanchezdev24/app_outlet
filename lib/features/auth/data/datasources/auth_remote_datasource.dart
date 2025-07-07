import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(String username, String password);
  Future<UserModel> register(Map<String, dynamic> userData);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<String> login(String username, String password) async {
    final response = await apiClient.post('/auth/login', {
      'username': username,
      'password': password,
    });
    return response['token'];
  }

  @override
  Future<UserModel> register(Map<String, dynamic> userData) async {
    final response = await apiClient.post('/users', userData);
    return UserModel.fromJson(response);
  }
}
