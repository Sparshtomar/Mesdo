import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/auth_controller.dart';
import 'package:mesdo/routes/app_routes.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

final AuthController authController = AuthController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'START FOR FREE',
                style: TextStyle(color: Colors.redAccent, fontSize: 20.0),
              ),
              Text(
                'Create new account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Email',
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200]!,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Your Email',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600]!,
                    ),
                  ),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 20.0),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Password',
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200]!,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Your Password',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600]!,
                    ),
                  ),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  await authController.signup(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                  if (authController.isLoggedIn.value) {
                    Get.offNamed(AppRoutes.LOGIN);
                  } else {
                    Get.snackbar(
                      'Signup Failed',
                      authController.errorMessage.value,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(324, 44),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text('Sign Up', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/or.png'),
                  height: 50,
                  width: 160,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  'Continue with Google',
                  style: TextStyle(color: Colors.black),
                ),
                icon: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: Image.asset('assets/google.png'),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(324, 44),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextSpan(
                        text: 'Sign in',
                        style: TextStyle(color: Colors.blue),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.offNamed(AppRoutes.LOGIN);
                              },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 150),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'By Signing up, you agree to our ',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms of Service ',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  // Get.toNamed(AppRoutes.SIGNUP);
                                },
                        ),
                        TextSpan(
                          text: 'and ',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  // Get.toNamed(AppRoutes.SIGNUP);
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
