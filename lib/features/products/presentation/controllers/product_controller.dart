import 'package:get/get.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/repositories/product_repository.dart';

class ProductController extends GetxController {
  final GetProductsUseCase _getProductsUseCase = Get.find();
  final GetCategoriesUseCase _getCategoriesUseCase = Get.find();
  final ProductRepository _productRepository = Get.find();

  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxList<String> brands = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<Product?> selectedProduct = Rx<Product?>(null);

  @override
  void onInit() {
    super.onInit();
    loadProducts();
    loadCategories();
    loadBrands();
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

  Future<void> loadCategories() async {
    try {
      final result = await _getCategoriesUseCase.call();
      categories.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> loadBrands() async {
    try {
      final result = await _productRepository.getBrands();
      brands.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> loadProductsByCategory(String category) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _productRepository.getProductsByCategory(category);
      filteredProducts.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadProductsByBrand(String brand) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _productRepository.getProductsByBrand(brand);
      filteredProducts.value = result;
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
