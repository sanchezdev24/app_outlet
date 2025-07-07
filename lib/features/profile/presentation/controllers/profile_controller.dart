import 'package:get/get.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final AuthController _authController = Get.find();

  Future<void> logout() async {
    await _authController.logout();
  }

  String get userName {
    final user = _authController.currentUser.value;
    if (user != null) {
      return '${user.firstName} ${user.lastName}';
    }
    return 'User';
  }

  String get userEmail {
    final user = _authController.currentUser.value;
    return user?.email ?? 'email@example.com';
  }
}
