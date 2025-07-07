import '../../../../core/services/storage_service.dart';
import '../../../../core/config/app_config.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<void> saveUser(UserModel user);
  Future<String?> getToken();
  Future<UserModel?> getUser();
  Future<bool> isLoggedIn();
  Future<void> clearData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> saveToken(String token) async {
    await StorageService.setString(AppConfig.userTokenKey, token);
    await StorageService.setBool(AppConfig.isLoggedInKey, true);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await StorageService.setObject(AppConfig.userDataKey, user.toJson());
  }

  @override
  Future<String?> getToken() async {
    return StorageService.getString(AppConfig.userTokenKey);
  }

  @override
  Future<UserModel?> getUser() async {
    final userData = StorageService.getObject(AppConfig.userDataKey);
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  @override
  Future<bool> isLoggedIn() async {
    return StorageService.getBool(AppConfig.isLoggedInKey);
  }

  @override
  Future<void> clearData() async {
    await StorageService.remove(AppConfig.userTokenKey);
    await StorageService.remove(AppConfig.userDataKey);
    await StorageService.setBool(AppConfig.isLoggedInKey, false);
  }
}
