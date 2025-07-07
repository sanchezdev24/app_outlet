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
}
