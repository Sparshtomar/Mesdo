import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoardingClasses/Qualifications.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';

class QuallificationNew extends StatefulWidget {
  const QuallificationNew({super.key});

  @override
  State<QuallificationNew> createState() => _QuallificationNewState();
}

class _QuallificationNewState extends State<QuallificationNew> {
  int currentPage = 2;
  CommonWidgets commonWidgets = CommonWidgets();
  final OnboardingController controller = Get.find<OnboardingController>();
  String? docType;

  String? qualification;
  String? university;
  String? course;
  String? specialization;
  String? courseType;
  String? passingYear;
  List<String> skills = [];

  late TextEditingController skillsController = TextEditingController();
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    // If editing, fill data
    final index = controller.editingIndex.value;
    if (index != null && index < controller.qualifications.length) {
      final q = controller.qualifications[index];
      qualification = q.qualification;
      university = q.university;
      course = q.course;
      specialization = q.specialization;
      passingYear = q.passingYear;
      courseType = q.courseType;
      descriptionController = TextEditingController(text: q.description);
      skills = q.skills;
      skillsController = TextEditingController();
    } else {
      controller.editingIndex.value = null; // reset stale index
      qualification = null;
      university = null;
      course = null;
      specialization = null;
      passingYear = null;
      courseType = null;
      descriptionController = TextEditingController();
      skillsController = TextEditingController();
    }
  }

  void saveQualification() {
    final qualificationObj = Qualifications(
      qualification: qualification!,
      university: university!,
      course: course!,
      specialization: specialization!,
      courseType: courseType!,
      passingYear: passingYear!,
      skills: skills,
      description: descriptionController.text.trim(),
    );

    if (controller.editingIndex.value != null) {
      controller.updateQualification(qualificationObj);
    } else {
      controller.addQualification(qualificationObj);
    }

    Get.toNamed(AppRoutes.QUALIFICATION_NEW_PREVIEW);
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
              commonWidgets.buildProgress(currentPage: currentPage),
              SizedBox(height: 20),
              commonWidgets.buildHeader(
                title: 'Qualifications',
                subtitle: 'Include all of your qualifications in this section.',
              ),
              const SizedBox(height: 30),
              commonWidgets.buildQualificationDropdown(
                headline: 'Qualification',
                selectedValue: qualification,
                onChanged: (newValue) {
                  setState(() {
                    qualification = newValue!;
                  });
                },
                items: [
                  'Graduation',
                  'PostGraduation',
                  'Intermediate',
                  'High School',
                ],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildQualificationDropdown(
                headline: 'University',
                selectedValue: university,
                onChanged: (newValue) {
                  setState(() {
                    university = newValue!;
                  });
                },
                items: ['AIIMS', 'KGMU'],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildQualificationDropdown(
                headline: 'Course',
                selectedValue: course,
                onChanged: (newValue) {
                  setState(() {
                    course = newValue!;
                  });
                },
                items: ['MBBS', 'MS', 'MD', 'BDMS'],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildQualificationDropdown(
                headline: 'Specialization',
                selectedValue: specialization,
                onChanged: (newValue) {
                  setState(() {
                    specialization = newValue!;
                  });
                },
                items: ['Radiology', 'Cardiology', 'Surgeon', 'Physician'],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildQualificationDropdown(
                headline: 'Course Type',
                selectedValue: courseType,
                onChanged: (newValue) {
                  setState(() {
                    courseType = newValue!;
                  });
                },
                items: ['Full Time', 'Part Time'],
              ),
              const SizedBox(height: 30),
              commonWidgets.buildQualificationDropdown(
                headline: 'Passing Year',
                selectedValue: passingYear,
                onChanged: (newValue) {
                  setState(() {
                    passingYear = newValue!;
                  });
                },
                items: ['2022', '2023', '2024', '2025'],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildSkillInputChips(
                controller: skillsController,
                skills: skills,
                onAdd: (skill) {
                  if (!skills.contains(skill)) {
                    setState(() {
                      skills.add(skill);
                    });
                  }
                },
                onDelete: (skill) {
                  setState(() {
                    skills.remove(skill);
                  });
                },
              ),
              const SizedBox(height: 20),
              commonWidgets.buildPara(
                height: 200,
                controller: descriptionController,
                hint: 'Tell us about qualification',
                keyboardinput: TextInputType.text,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildUpload(
                selectedValue: docType,
                onChanged: (newValue) {
                  setState(() {
                    docType = newValue!;
                  });
                },
                onPressedUpload: () {},
                onPressedSave: () {
                  if (qualification == null ||
                      university == null ||
                      course == null ||
                      specialization == null ||
                      courseType == null ||
                      passingYear == null ||
                      descriptionController.text.trim().isEmpty) {
                    Get.snackbar(
                      'Missing Information',
                      'Please fill all fields before continuing.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  saveQualification();
                },
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
                      Get.toNamed(AppRoutes.WORKEXPERIENCE_NEW);
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
