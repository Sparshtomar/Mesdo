import 'package:get/get.dart';
import 'package:mesdo/controller/auth_controller.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(OnboardingController());
  }
}
