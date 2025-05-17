import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoardingClasses/Qualifications.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';
import 'package:mesdo/screens/user/onboarding/personal_information.dart';

class Qualification extends StatefulWidget {
  const Qualification({super.key});

  @override
  State<Qualification> createState() => _QualificationState();
}

// Local model to hold dynamic form fields
class QualificationInputModel {
  String? university;
  String? course;
  String? passingYear;
  String? specialization;
  //TextEditingController skillsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
}

class _QualificationState extends State<Qualification> {
  List<QualificationInputModel> inputs = [QualificationInputModel()];
  CommonWidgets commonWidgets = CommonWidgets();
  final OnboardingController onboardingController = Get.find<OnboardingController>();


  void addNewInput() {
    setState(() {
      inputs.add(QualificationInputModel());
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
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonWidgets.buildHeader(
                title: 'Qualifications',
                subtitle: 'Include all of your qualification in this section',
              ),
              const SizedBox(height: 30),
              ...List.generate(inputs.length, (index) {
                final item = inputs[index];
                return Column(
                  children: [
                    commonWidgets.buildQualificationDropdown(
                      headline: 'University',
                      selectedValue: item.university,
                      onChanged: (val) => setState(() => item.university = val),
                      items: ['AIIMS', 'KGMU', 'BHU'],
                    ),
                    const SizedBox(height: 20),
                    commonWidgets.buildQualificationDropdown(
                      headline: 'Course',
                      selectedValue: item.course,
                      onChanged: (val) => setState(() => item.course = val),
                      items: ['MBBS', 'MS', 'BPT'],
                    ),
                    const SizedBox(height: 20),
                    commonWidgets.buildQualificationDropdown(
                      headline: 'Passing Year',
                      selectedValue: item.passingYear,
                      onChanged:
                          (val) => setState(() => item.passingYear = val),
                      items: ['2020', '2021', '2022'],
                    ),
                    const SizedBox(height: 20),
                    commonWidgets.buildQualificationDropdown(
                      headline: 'Specialization',
                      selectedValue: item.specialization,
                      onChanged:
                          (val) => setState(() => item.specialization = val),
                      items: ['Cardiology', 'Neurology', 'Orthopedics'],
                    ),
                    // const SizedBox(height: 20),
                    // commonWidgets.buildTextEntiresWithoutRed(
                    //   title: 'Skills (seperated by ,)',
                    //   hint: 'Add Skills',
                    //   keyboardinput: TextInputType.text,
                    //   controller: item.skillsController,
                    // ),
                    const SizedBox(height: 20),
                    commonWidgets.buildPara(
                      controller: item.descriptionController,
                      hint: 'Add Description',
                      height: 300,
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
                  'Add Qualification',
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
                     // Get.toNamed(AppRoutes.WORK_EXPERIENCE);
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
                      // onboardingController.qualifications.value =
                      //     inputs
                      //         .map(
                      //           (item) => Qualifications(
                      //             university: item.university ?? '',
                      //             course: item.course ?? '',
                      //             specialization: item.specialization ?? '',
                      //             passingYear: item.passingYear ?? '',
                      //             description:
                      //                 item.descriptionController.text.trim(),
                      //           ),
                      //         )
                      //         .toList();

                      // onboardingController.skills.value =
                      //     inputs
                      //         .expand(
                      //           (item) => item.skillsController.text
                      //               .split(',')
                      //               .map((s) => s.trim()),
                      //         )
                      //         .where((s) => s.isNotEmpty)
                      //         .toList();

                     // Get.toNamed(AppRoutes.WORK_EXPERIENCE);
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
