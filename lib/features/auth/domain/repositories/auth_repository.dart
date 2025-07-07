import '../entities/user.dart';

abstract class AuthRepository {
  Future<String> login(String username, String password);
  Future<User> register(Map<String, dynamic> userData);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<bool> isLoggedIn();
}
