import 'package:get/get.dart';
import '../network/api_client.dart';
import '../services/storage_service.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/products/data/datasources/product_remote_datasource.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/domain/usecases/get_products_usecase.dart';
import '../../features/products/domain/usecases/get_categories_usecase.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    _initializeStorage();
    _initializeCore();
    _initializeAuth();
    _initializeProducts();
  }

  void _initializeStorage() {
    StorageService.init();
  }

  void _initializeCore() {
    // Core dependencies
    Get.put<ApiClient>(ApiClient(), permanent: true);
  }

  void _initializeAuth() {
    // Auth data layer
    Get.put<AuthLocalDataSource>(AuthLocalDataSourceImpl(), permanent: true);
    Get.put<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(Get.find<ApiClient>()),
      permanent: true,
    );

    // Auth repository
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        Get.find<AuthRemoteDataSource>(),
        Get.find<AuthLocalDataSource>(),
      ),
      permanent: true,
    );

    // Auth use cases
    Get.put<LoginUseCase>(
      LoginUseCase(Get.find<AuthRepository>()),
      permanent: true,
    );
    Get.put<RegisterUseCase>(
      RegisterUseCase(Get.find<AuthRepository>()),
      permanent: true,
    );
    Get.put<LogoutUseCase>(
      LogoutUseCase(Get.find<AuthRepository>()),
      permanent: true,
    );
    Get.put<GetCurrentUserUseCase>(
      GetCurrentUserUseCase(Get.find<AuthRepository>()),
      permanent: true,
    );

    // Auth controller
    Get.put<AuthController>(AuthController(), permanent: true);
  }

  void _initializeProducts() {
    // Products data layer
    Get.put<ProductRemoteDataSource>(
      ProductRemoteDataSourceImpl(Get.find<ApiClient>()),
      permanent: true,
    );

    // Products repository
    Get.put<ProductRepository>(
      ProductRepositoryImpl(Get.find<ProductRemoteDataSource>()),
      permanent: true,
    );

    // Products use cases
    Get.put<GetProductsUseCase>(
      GetProductsUseCase(Get.find<ProductRepository>()),
      permanent: true,
    );
    Get.put<GetCategoriesUseCase>(
      GetCategoriesUseCase(Get.find<ProductRepository>()),
      permanent: true,
    );
  }
}
