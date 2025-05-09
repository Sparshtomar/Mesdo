import 'package:get/get.dart';
import 'package:mesdo/services/auth_service.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var errorMessage = "".obs;
  var token = "".obs;

  final AuthService authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    getToken(); // fetch token on init
  }

  // HANDLE SIGNUP
  Future<void> signup(String email, String password) async {
    var response = await authService.signup(email, password);
    if (response["success"]) {
      isLoggedIn.value = true;
      token.value = response['token'];
    } else {
      errorMessage.value = response['message'];
    }
  }

  // HANDLE LOGIN
  Future<void> login(String email, String password) async {
    var response = await authService.login(email, password);
    if (response["success"]) {
      isLoggedIn.value = true;
      token.value = response['token'];
    } else {
      errorMessage.value = response['message'];
    }
  }

  // GET SAVED TOKEN
  Future<void> getToken() async {
    String? storedToken = await authService.getToken();
    if (storedToken != null) {
      isLoggedIn.value = true;
      token.value = storedToken;
    } else {
      isLoggedIn.value = false;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await authService.logout();
    isLoggedIn.value = false;
    token.value = "";
  }
}
