import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/bindings/initial_binding.dart';
import 'package:mobile/core/services/storage_service.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/routes/app_pages.dart';
import 'package:mobile/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Storage Service before app starts
  final storage = StorageService();
  await storage.init();
  Get.put(storage, permanent: true); // Early inject for InitialBinding to find or just rely on InitialBinding

  // Determine initial route based on token
  final token = storage.getToken();
  final initialRoute = token != null ? AppRoutes.HOME : AppRoutes.LOGIN;

  runApp(
    GetMaterialApp(
      title: 'Kimia - Violences Femmes RDC',
      initialBinding: InitialBinding(),
      initialRoute: initialRoute,
      getPages: AppPages.pages,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
    ),
  );
}
