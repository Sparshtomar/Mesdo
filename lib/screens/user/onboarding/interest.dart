import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';
import 'package:mesdo/screens/user/onboarding/personal_information.dart';
import 'package:get/get.dart';

class Interest extends StatefulWidget {
  const Interest({super.key});

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  final List<String> allInterests = [
    'Dental',
    'Surgery',
    'Radiology',
    'Pathology',
    'Dermatology',
  ];
  @override
  void initState() {
    super.initState();
    selectedInterests = List<String>.from(onboardingController.interests);
  }

  List<String> selectedInterests = [];
  final OnboardingController onboardingController =
      Get.find<OnboardingController>();
  CommonWidgets commonWidgets = CommonWidgets();

  void toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Column(
            children: [
              commonWidgets.buildHeader(
                title: 'What are you interested in ?',
                subtitle: 'Choose 3 or more',
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    allInterests.map((interest) {
                      final isSelected = selectedInterests.contains(interest);
                      return RawChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: isSelected ? Colors.white : Colors.grey,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(interest),
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (_) => toggleInterest(interest),
                        selectedColor: Colors.blue,
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        showCheckmark:
                            false, // key line to disable default checkmark
                      );
                    }).toList(),
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
                      if (selectedInterests.length < 3) {
                        Get.snackbar(
                          'Error Occured',
                          'Choose at least 3 interests to continue',
                        );
                      } else {
                        onboardingController.interests.assignAll(
                          selectedInterests,
                        );
                        // Print all collected data
                        debugPrint("------- Onboarding Data --------");
                        debugPrint(
                          JsonEncoder.withIndent(
                            '  ',
                          ).convert(onboardingController.toJson()),
                          wrapWidth: 1024,
                        );
                        debugPrint("--------------------------------");
                      }
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
