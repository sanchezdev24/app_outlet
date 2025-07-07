import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../../../../core/routes/app_routes.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    final categoryIcons = {
      'electronics': Icons.electrical_services,
      'jewelery': Icons.diamond,
      "men's clothing": Icons.man,
      "women's clothing": Icons.woman,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
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
                  onPressed: () => controller.loadCategories(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final categories = controller.categories;

        if (categories.isEmpty) {
          return const Center(child: Text('No categories found'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final icon = categoryIcons[category] ?? Icons.category;

            return Card(
              elevation: 4,
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.filteredProducts,
                    arguments: {
                      'type': 'category',
                      'value': category,
                      'title': 'Category: ${category.toUpperCase()}',
                    },
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 48, color: Colors.blue),
                    const SizedBox(height: 12),
                    Text(
                      category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
