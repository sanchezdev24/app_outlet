import 'package:get/get.dart';
import '../network/api_client.dart';
import '../../features/products/data/datasources/product_remote_datasource.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/domain/usecases/get_products_usecase.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Core dependencies
    Get.put<ApiClient>(ApiClient(), permanent: true);

    // Data layer
    Get.put<ProductRemoteDataSource>(
      ProductRemoteDataSourceImpl(Get.find<ApiClient>()),
      permanent: true,
    );

    // Repository
    Get.put<ProductRepository>(
      ProductRepositoryImpl(Get.find<ProductRemoteDataSource>()),
      permanent: true,
    );

    // Use cases
    Get.put<GetProductsUseCase>(
      GetProductsUseCase(Get.find<ProductRepository>()),
      permanent: true,
    );
  }
}
