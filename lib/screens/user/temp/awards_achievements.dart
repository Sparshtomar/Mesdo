import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoardingClasses/Achievement.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';
import 'package:mesdo/screens/user/onboarding/interest.dart';

class AwardsAchievements extends StatefulWidget {
  const AwardsAchievements({super.key});

  @override
  State<AwardsAchievements> createState() => _AwardsAchievementsState();
}

class AwardsInputModel {
  String? yearValue;
  TextEditingController awardsController = TextEditingController();
  TextEditingController issuerController = TextEditingController();
  //TextEditingController yearController = TextEditingController();
  TextEditingController decriptionController = TextEditingController();

  final List<String> yearList =
      List.generate(
        DateTime.now().year - 1950 + 1,
        (index) => (1950 + index).toString(),
      ).reversed.toList();
}

class _AwardsAchievementsState extends State<AwardsAchievements> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var result = await Get.to(() => Interest());
      if (result == 'goToWorkExperience') {
        Get.back();
      }
    });
  }

  List<AwardsInputModel> inputs = [AwardsInputModel()];
  CommonWidgets commonWidgets = CommonWidgets();
  final OnboardingController onboardingController =
      Get.find<OnboardingController>();

  void addNewInput() {
    setState(() {
      inputs.add(AwardsInputModel());
    });
  }

  void removeInput(int index) {
    setState(() {
      inputs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonWidgets.buildHeader(
                title: 'Awards & Achievements',
                subtitle:
                    'Include all of your awards and achievements in this section',
              ),
              const SizedBox(height: 30),
              ...List.generate(inputs.length, (index) {
                final item = inputs[index];
                return Column(
                  children: [
                    commonWidgets.buildTextEntiresWithoutRed(
                      title: 'Award',
                      hint: 'Award',
                      keyboardinput: TextInputType.text,
                      controller: item.awardsController,
                    ),
                    const SizedBox(height: 20),
                    commonWidgets.buildTextEntiresWithoutRed(
                      title: 'Issuer',
                      hint: 'Issuer',
                      keyboardinput: TextInputType.text,
                      controller: item.issuerController,
                    ),
                    const SizedBox(height: 20),
                    commonWidgets.buildQualificationDropdown(
                      headline: 'Year',
                      selectedValue: item.yearValue,
                      onChanged: (newValue) {
                        setState(() {
                          item.yearValue = newValue;
                        });
                      },
                      items: item.yearList,
                    ),
                    const SizedBox(height: 20),
                    commonWidgets.buildPara(
                      height: 300,
                      controller: item.decriptionController,
                      hint: 'Description',
                      keyboardinput: TextInputType.text,
                    ),
                    if (inputs.length > 1)
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => removeInput(index),
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                );
              }),
              ElevatedButton.icon(
                onPressed: addNewInput,
                label: Text(
                  'Add Achievement',
                  style: TextStyle(color: Colors.grey[800]),
                ),
                icon: const Icon(Icons.add),
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(0),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  overlayColor: WidgetStateProperty.all(Colors.grey[200]),
                  iconColor: WidgetStateProperty.all(Colors.grey[800]),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  commonWidgets.buildButton(
                    text: 'Skip',
                    backgroundColor: Colors.grey[200]!,
                    textColor: Colors.blue,
                    height: 44,
                    width: 140,
                    onPressed: () {
                      Get.toNamed(AppRoutes.INTEREST);
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
                      onboardingController.Achievements.value =
                          inputs
                              .map(
                                (item) => Achievement(
                                  award: item.awardsController.text.trim(),
                                  issuer: item.issuerController.text.trim(),
                                  year: item.yearValue ?? '',
                                  description:
                                      item.decriptionController.text.trim(),
                                ),
                              )
                              .toList();

                      Get.toNamed(AppRoutes.INTEREST);
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
