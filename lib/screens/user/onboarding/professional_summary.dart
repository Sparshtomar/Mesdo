import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';
import 'package:mesdo/screens/user/onboarding/personal_information.dart';

class ProfessionalSummary extends StatefulWidget {
  const ProfessionalSummary({super.key});

  @override
  State<ProfessionalSummary> createState() => _ProfessionalSummaryState();
}

class _ProfessionalSummaryState extends State<ProfessionalSummary> {
  int currentPage = 1;
  CommonWidgets commonWidgets = CommonWidgets();
  final OnboardingController onboardingController =
      Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Column(
            children: [
              commonWidgets.buildProgress(currentPage: currentPage),
              SizedBox(height: 20),
              commonWidgets.buildHeader(
                title: 'Professional Summary',
                subtitle:
                    'Include all of your relevant experiences and dates in this section',
              ),
              const SizedBox(height: 30),
              commonWidgets.buildTextEntires(
                title: 'Tagline',
                hint: 'Enter Tagline',
                keyboardinput: TextInputType.text,
                controller: onboardingController.taglineController,
              ),
              const SizedBox(height: 30),
              commonWidgets.buildPara(
                height: 300,
                controller: onboardingController.aboutYouController,
                hint: 'Enter Professional Summary',
                keyboardinput: TextInputType.text,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  commonWidgets.buildButton(
                    text: 'Previous',
                    backgroundColor: Colors.grey[200]!,
                    textColor: Colors.grey,
                    height: 44,
                    width: 140,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const SizedBox(width: 20),
                  commonWidgets.buildButton(
                    text: 'Continue',
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    height: 44,
                    width: 140,
                    onPressed: () {
                      Get.toNamed(AppRoutes.QUALIFICATION_NEW);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
