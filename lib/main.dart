import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/config/app_config.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/bindings/initial_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConfig.appName,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
    );
  }
}
