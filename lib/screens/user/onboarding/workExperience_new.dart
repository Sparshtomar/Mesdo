import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoardingClasses/Experience.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';

class WorkexperienceNew extends StatefulWidget {
  const WorkexperienceNew({super.key});

  @override
  State<WorkexperienceNew> createState() => _WorkexperienceNewState();
}

class _WorkexperienceNewState extends State<WorkexperienceNew> {
  int currentPage = 3;
  CommonWidgets commonWidgets = CommonWidgets();
  final OnboardingController controller = Get.find<OnboardingController>();
  String? docType;

  String? employmentType;
  String? location;
  String? startDate;
  String? endDate;
  bool? currentlyWorking;
  List<String> skills = [];

  late TextEditingController jobController = TextEditingController();
  late TextEditingController hospitalController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController skillsController = TextEditingController();
  late TextEditingController startDateController = TextEditingController();
  late TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // If editing, fill data
    final index = controller.editingIndexWork.value;
    if (index != null && index < controller.workExperience.length) {
      final w = controller.workExperience[index];
      jobController = TextEditingController(text: w.jobTitle);
      hospitalController = TextEditingController(text: w.hospital);
      employmentType = w.employmentType;
      location = w.location;
      startDate = w.startDate;
      endDate = w.endDate;
      startDateController.text = startDate ?? '';
      endDateController.text = endDate ?? '';
      currentlyWorking = w.currentlyWorking;
      descriptionController = TextEditingController(text: w.description);
      skills = w.skills;
      skillsController = TextEditingController();
    } else {
      controller.editingIndexWork.value = null; // reset stale index
      employmentType = null;
      location = null;
      startDate = null;
      endDate = null;
      currentlyWorking = false;
      descriptionController = TextEditingController();
      skillsController = TextEditingController();
    }
  }

  void saveWorkExperience() {
    final workExperienceObj = Experience(
      jobTitle: jobController.text.trim(),
      hospital: hospitalController.text.trim(),
      employmentType: employmentType!,
      location: location!,
      startDate: startDate!,
      endDate: currentlyWorking == true ? null : endDate,
      skills: skills,
      currentlyWorking: currentlyWorking!,
      description: descriptionController.text.trim(),
    );

    if (controller.editingIndexWork.value != null) {
      controller.updateWorkExperience(workExperienceObj);
    } else {
      controller.addWorkExperience(workExperienceObj);
    }

    Get.toNamed(AppRoutes.WORKEXPERIENCE_NEW_PREVIEW);
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
                title: 'Work Experience',
                subtitle:
                    'Include all of your work experience in this section.',
              ),
              const SizedBox(height: 30),
              commonWidgets.buildTextEntiresWithoutRed(
                title: 'Job Title',
                hint: 'Senior Dermatologist',
                keyboardinput: TextInputType.text,
                controller: jobController,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildTextEntiresWithoutRed(
                title: 'Hospital/Clinic',
                hint: 'Apollo Hospital',
                keyboardinput: TextInputType.text,
                controller: hospitalController,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildQualificationDropdown(
                headline: 'Employment Type',
                selectedValue: employmentType,
                onChanged: (newValue) {
                  setState(() {
                    employmentType = newValue!;
                  });
                },
                items: ['Part Time', 'Full Time'],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildQualificationDropdown(
                headline: 'Location',
                selectedValue: location,
                onChanged: (newValue) {
                  setState(() {
                    location = newValue!;
                  });
                },
                items: ['Delhi', 'Banglore', 'Pune', 'Hyderabad'],
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
              Row(
                children: [
                  Expanded(
                    child: commonWidgets.buildDateEntires(
                      context: context,
                      title: 'Start Date',
                      hint: 'start',
                      keyboardinput: TextInputType.datetime,
                      controller: startDateController,
                      readOnly: false,
                      ontap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          final date = pickedDate.toString().split(' ')[0];
                          startDate = date;
                          startDateController.text = date;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: commonWidgets.buildDateEntires(
                      context: context,
                      title: 'End Date',
                      hint: 'end',
                      keyboardinput: TextInputType.datetime,
                      controller: endDateController,
                      readOnly: currentlyWorking ?? false,
                      ontap:
                          currentlyWorking == true
                              ? null
                              : () async {
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  final date =
                                      pickedDate.toString().split(' ')[0];
                                  endDate = date;
                                  endDateController.text = date;
                                }
                              },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: currentlyWorking ?? false,
                    onChanged: (bool? value) {
                      setState(() {
                        currentlyWorking = value ?? false;
                        if (value == true) {
                          endDateController.clear();
                          endDate = null;
                        }
                        FocusScope.of(context).unfocus(); // dismiss keyboard
                      });
                    },
                  ),
                  Text('Present'),
                ],
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
                  if (jobController.text.trim().isEmpty ||
                      hospitalController.text.trim().isEmpty ||
                      employmentType == null ||
                      location == null ||
                      startDate == null ||
                      (currentlyWorking != true &&
                          (endDate == null || endDate!.isEmpty)) ||
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
                  saveWorkExperience();
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
                      Get.toNamed(AppRoutes.AWARDS_NEW);
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
