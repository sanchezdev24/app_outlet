import 'package:get/get.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../../../core/routes/app_routes.dart';

class AuthController extends GetxController {
  final LoginUseCase _loginUseCase = Get.find();
  final RegisterUseCase _registerUseCase = Get.find();
  final LogoutUseCase _logoutUseCase = Get.find();
  final GetCurrentUserUseCase _getCurrentUserUseCase = Get.find();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    try {
      final user = await _getCurrentUserUseCase.call();
      if (user != null) {
        currentUser.value = user;
        isLoggedIn.value = true;
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _loginUseCase.call(username, password);
      final user = await _getCurrentUserUseCase.call();

      currentUser.value = user;

      /* currentUser.value = UserModel(
        id: 10,
        email: "10@gmail.com",
        username: "Romulo",
        firstName: "Sanchez",
        lastName: "Baltazar",
        phone: "9841866731",
        address: AddressModel(
          city: "Chilchota",
          street: "Nacional",
          number: 25,
          zipcode: "59797",
        ),
      ); */
      isLoggedIn.value = true;

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(Map<String, dynamic> userData) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final user = await _registerUseCase.call(userData);
      currentUser.value = user;
      isLoggedIn.value = true;

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _logoutUseCase.call();
      currentUser.value = null;
      isLoggedIn.value = false;
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }
}
