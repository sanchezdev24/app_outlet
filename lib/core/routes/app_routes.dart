import 'package:get/get.dart';
import '../../features/products/presentation/pages/product_list_page.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/products/presentation/bindings/product_binding.dart';

class AppRoutes {
  static const String home = '/';
  static const String productDetail = '/product-detail';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const ProductListPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: productDetail,
      page: () => const ProductDetailPage(),
      binding: ProductBinding(),
    ),
  ];
}
