import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<String> login(String username, String password) async {
    final token = await remoteDataSource.login(username, password);
    await localDataSource.saveToken(token);
    return token;
  }

  @override
  Future<User> register(Map<String, dynamic> userData) async {
    final user = await remoteDataSource.register(userData);
    await localDataSource.saveUser(user);
    return user;
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearData();
  }

  @override
  Future<User?> getCurrentUser() async {
    return await localDataSource.getUser();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.isLoggedIn();
  }
}
