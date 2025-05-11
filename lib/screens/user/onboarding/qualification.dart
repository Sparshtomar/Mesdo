import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoardingClasses/Qualifications.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';
import 'package:mesdo/screens/user/onboarding/personal_information.dart';

class Qualification extends StatefulWidget {
  const Qualification({super.key});

  @override
  State<Qualification> createState() => _QualificationState();
}

class _QualificationState extends State<Qualification> {
  String? qualificationValue;
  String? universityValue;
  String? courseValue;
  String? passingYearValue;
  String? specializationValue;
  String? courseTypeValue;
  TextEditingController skillsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CommonWidgets commonWidgets = CommonWidgets();
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
              commonWidgets.buildQualificationDropdown(
                headline: 'Qualification',
                selectedValue: qualificationValue,
                onChanged: (newValue) {
                  setState(() {
                    qualificationValue = newValue;
                  });
                },
                items: ['MBBS', 'MS', 'BDMS'],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildQualificationDropdown(
                headline: 'University',
                selectedValue: universityValue,
                onChanged: (newValue) {
                  setState(() {
                    universityValue = newValue;
                  });
                },
                items: ['AIIMS', 'KGMU', 'BHU'],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildQualificationDropdown(
                headline: 'Course',
                selectedValue: courseValue,
                onChanged: (newValue) {
                  setState(() {
                    courseValue = newValue;
                  });
                },
                items: ['MBBS', 'MS', 'BPT'],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildQualificationDropdown(
                headline: 'Passing Year',
                selectedValue: passingYearValue,
                onChanged: (newValue) {
                  setState(() {
                    passingYearValue = newValue;
                  });
                },
                items: ['2020', '2021', '2022'],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildQualificationDropdown(
                headline: 'Specialization',
                selectedValue: specializationValue,
                onChanged: (newValue) {
                  setState(() {
                    specializationValue = newValue;
                  });
                },
                items: ['Cardiology', 'Neurology', 'Orthopedics'],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildQualificationDropdown(
                headline: 'Course Type',
                selectedValue: courseTypeValue,
                onChanged: (newValue) {
                  setState(() {
                    courseTypeValue = newValue;
                  });
                },
                items: ['Undergraduate', 'Postgraduate', 'Diploma'],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildTextEntiresWithoutRed(
                title: 'Skills (seperated by ,)',
                hint: 'Add Skills',
                keyboardinput: TextInputType.text,
                controller: skillsController,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildPara(
                height: 300,
                controller: descriptionController,
                hint: 'Add Description',
                keyboardinput: TextInputType.text,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text('Add Qualification'),
                icon: Icon(Icons.add),
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
                      Get.toNamed(AppRoutes.WORK_EXPERIENCE);
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
                      onboardingController.qualifications.value = [
                        Qualifications(
                          university: universityValue ?? '',
                          course: courseValue ?? '',
                          specialization: specializationValue ?? '',
                          passingYear: passingYearValue ?? '',
                          description: descriptionController.text.trim(),
                        ),
                      ];
                      onboardingController.skills.value =
                          skillsController.text
                              .split(',')
                              .map((s) => s.trim())
                              .toList();
                      Get.toNamed(AppRoutes.WORK_EXPERIENCE);
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
