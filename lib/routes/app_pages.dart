import 'package:get/get.dart';
import 'package:mesdo/screens/authentication/forgot_password.dart';
import 'app_routes.dart';
import 'package:mesdo/screens/authentication/welcome_screen.dart';
import 'package:mesdo/screens/authentication/login.dart';
import 'package:mesdo/screens/authentication/signup.dart';
import 'package:mesdo/screens/authentication/change_password.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.WELCOME_SCREEN, page: () => WelcomeScreen()),
    GetPage(name: AppRoutes.LOGIN, page: () => Login()),
    GetPage(name: AppRoutes.SIGNUP, page: () => Signup()),
    GetPage(name: AppRoutes.FORGOT_PASSWORD, page: () => ForgotPassword()),
    GetPage(name: AppRoutes.CHANGE_PASSWORD, page: () => ChangePassword()),
  ];
}
