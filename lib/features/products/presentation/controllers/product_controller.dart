import 'package:get/get.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products_usecase.dart';

class ProductController extends GetxController {
  final GetProductsUseCase _getProductsUseCase = Get.find();

  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<Product?> selectedProduct = Rx<Product?>(null);

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _getProductsUseCase.call();
      products.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void selectProduct(Product product) {
    selectedProduct.value = product;
  }

  List<Product> get clothingProducts {
    return products
        .where(
          (product) =>
              product.category == "men's clothing" ||
              product.category == "women's clothing",
        )
        .toList();
  }
}
