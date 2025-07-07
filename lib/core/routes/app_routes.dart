import 'package:get/get.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/bindings/auth_binding.dart';
import '../../features/home/presentation/pages/main_page.dart';
import '../../features/home/presentation/bindings/home_binding.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/products/presentation/pages/filtered_products_page.dart';
import '../../features/products/presentation/bindings/product_binding.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/bindings/profile_binding.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String productDetail = '/product-detail';
  static const String filteredProducts = '/filtered-products';
  static const String profile = '/profile';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashPage(),
      binding: AuthBinding(),
    ),
    GetPage(name: login, page: () => const LoginPage(), binding: AuthBinding()),
    GetPage(
      name: register,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: home,
      page: () => const MainPage(),
      bindings: [HomeBinding(), ProductBinding()],
    ),
    GetPage(
      name: productDetail,
      page: () => const ProductDetailPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: filteredProducts,
      page: () => const FilteredProductsPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
  ];
}
