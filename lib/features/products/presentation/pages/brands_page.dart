import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../../../../core/routes/app_routes.dart';

class BrandsPage extends StatelessWidget {
  const BrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Brands'),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
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
                  onPressed: () => controller.loadBrands(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final brands = controller.brands;

        if (brands.isEmpty) {
          return const Center(child: Text('No brands found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            final brand = brands[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    brand[0].toUpperCase(),
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  brand,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.toNamed(
                    AppRoutes.filteredProducts,
                    arguments: {
                      'type': 'brand',
                      'value': brand,
                      'title': 'Brand: $brand',
                    },
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
