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
    // Load previously selected interests
    selectedInterests = List<String>.from(onboardingController.interests);
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   var result = await Get.to(() => WorkExpPreview());
    //   if (result == 'goToWorkExperience') {
    //      Get.back(result: 'goToWorkExperience');
    //   }
    // });
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
                      return ChoiceChip(
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
                        selectedColor: Colors.blue,
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        onSelected: (_) => toggleInterest(interest),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 20),
              commonWidgets.buildButton(
                text: 'Continue',
                backgroundColor:
                    selectedInterests.length >= 3
                        ? Colors.blue
                        : Colors.grey[300]!,
                textColor:
                    selectedInterests.length >= 3
                        ? Colors.white
                        : Colors.grey[500]!,
                height: 44,
                width: 317,
                onPressed: () {
                  if (selectedInterests.length >= 3) {
                    onboardingController.interests.value = selectedInterests;
                   // Get.toNamed(AppRoutes.WORK_EXP_PREVIEW);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
