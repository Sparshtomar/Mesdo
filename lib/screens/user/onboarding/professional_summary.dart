import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';
import 'package:mesdo/screens/user/onboarding/personal_information.dart';

class ProfessionalSummary extends StatefulWidget {
  const ProfessionalSummary({super.key});

  @override
  State<ProfessionalSummary> createState() => _ProfessionalSummaryState();
}

class _ProfessionalSummaryState extends State<ProfessionalSummary> {
  CommonWidgets commonWidgets = CommonWidgets();
  TextEditingController taglineController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Column(
            children: [
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
                controller: taglineController,
              ),
              const SizedBox(height: 30),
              commonWidgets.buildPara(
                height: 300,
                controller: summaryController,
                hint: 'Enter Professional Summary',
                keyboardinput: TextInputType.text,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  commonWidgets.buildButton(
                    text: 'skip',
                    backgroundColor: Colors.grey[200]!,
                    textColor: Colors.blue,
                    height: 44,
                    width: 140,
                    onPressed: () {
                      Get.toNamed(AppRoutes.QUALIFICATION);
                    },
                  ),
                  const SizedBox(width: 10),
                  commonWidgets.buildButton(
                    text: 'Continue',
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    height: 44,
                    width: 140,
                    onPressed: () {
                      onboardingController.tagline.value =
                          taglineController.text.trim();
                      onboardingController.aboutYou.value =
                          summaryController.text.trim();
                      Get.toNamed(AppRoutes.QUALIFICATION);
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
