import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mesdo/bindings/initial_binding.dart';
import 'package:mesdo/routes/app_pages.dart';
import 'package:mesdo/routes/app_routes.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Mesdo',
    initialBinding: InitialBinding(),
    initialRoute: AppRoutes.WELCOME_SCREEN,
    getPages: AppPages.pages,
  ));
}