import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts() async {
    return await remoteDataSource.getProducts();
  }

  @override
  Future<Product> getProductById(int id) async {
    return await remoteDataSource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final products = await remoteDataSource.getProducts();
    return products.where((product) => product.category == category).toList();
  }

  @override
  Future<List<String>> getCategories() async {
    return await remoteDataSource.getCategories();
  }

  @override
  Future<List<String>> getBrands() async {
    // Since the API doesn't provide brands, we'll extract them from product titles
    final products = await remoteDataSource.getProducts();
    final brands = <String>{};

    for (final product in products) {
      // Extract brand from title (first word usually)
      final words = product.title.split(' ');
      if (words.isNotEmpty) {
        brands.add(words.first);
      }
    }

    return brands.toList();
  }

  @override
  Future<List<Product>> getProductsByBrand(String brand) async {
    final products = await remoteDataSource.getProducts();
    return products
        .where(
          (product) =>
              product.title.toLowerCase().contains(brand.toLowerCase()),
        )
        .toList();
  }
}
