import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'https://backendurl.com';
  final Dio dio = Dio();

  //REGISTER USER (SIGNUP)
  Future<Map<String, dynamic>> signup(String email, String password) async {
    try {
      final response = await dio.post(
        '$baseUrl/signup',
        data: json.encode({"email": email, "password": password}),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  //LOGIN USER (SIGNIN)
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dio.post(
        '$baseUrl/signin',
        data: json.encode({"email": email, "password": password}),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  //LOGOUT USER
  Future<void> logout() async {
    await clearToken();
  }

  //HANDLE RESPONSE
  Future<Map<String, dynamic>> _handleResponse(Response response) async {
    if (response.statusCode == 200) {
      final responseData = response.data;
      await saveToken(responseData['token']);
      return {"success": true, "token": responseData['token']};
    } else {
      return {"success": false, "message": response.data['message']};
    }
  }

  //HANDLE ERRORS
  Future<Map<String, dynamic>> _handleError(DioException error) async {
    if (error.response != null) {
      return {
        "success": false,
        "message": error.response?.data['message'] ?? 'Unknown error',
      };
    } else {
      return {"success": false, "message": error.message};
    }
  }

  //SAVE TOKEN
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  //GET TOKEN
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  //Clear TOKEN
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}
