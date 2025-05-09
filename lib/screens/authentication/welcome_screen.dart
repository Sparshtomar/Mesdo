import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:mesdo/routes/app_routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 150.0),
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image(
                    image: AssetImage('assets/background_effect.png'),
                    width: 171.0,
                    height: 172.0,
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage('assets/welcome_logo.png'),
                    width: 285.0,
                    height: 247.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
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
            Image.asset('assets/or.png', height: 50.0, width: 160.0),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.LOGIN);
              },
              icon: Icon(Icons.mail),
              label: Text(
                'Continue with E-mail',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(324, 44),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.work),
              label: Text(
                'Continue as Recruiter',
                style: TextStyle(color: Colors.blue),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                minimumSize: Size(324, 44),
                foregroundColor: Colors.blue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  TextSpan(
                    text: 'Create Account',
                    style: TextStyle(color: Colors.blue),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(AppRoutes.SIGNUP);
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
