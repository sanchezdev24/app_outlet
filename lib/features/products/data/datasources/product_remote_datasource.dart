import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(int id);
  Future<List<String>> getCategories();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await apiClient.getList('/products');
    return response.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final response = await apiClient.get('/products/$id');
    return ProductModel.fromJson(response);
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await apiClient.getList('/products/categories');
    return response.cast<String>();
  }
}
