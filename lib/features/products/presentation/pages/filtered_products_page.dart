import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';
import '../../../../core/widgets/loading_widget.dart';

class FilteredProductsPage extends StatelessWidget {
  const FilteredProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final arguments = Get.arguments as Map<String, dynamic>;
    final type = arguments['type'] as String;
    final value = arguments['value'] as String;
    final title = arguments['title'] as String;

    // Load filtered products based on type
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (type == 'category') {
        controller.loadProductsByCategory(value);
      } else if (type == 'brand') {
        controller.loadProductsByBrand(value);
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget();
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${controller.errorMessage}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (type == 'category') {
                      controller.loadProductsByCategory(value);
                    } else if (type == 'brand') {
                      controller.loadProductsByBrand(value);
                    }
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final filteredProducts = controller.filteredProducts;

        if (filteredProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text('No products found for $value'),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            return ProductCard(product: filteredProducts[index]);
          },
        );
      }),
    );
  }
}
