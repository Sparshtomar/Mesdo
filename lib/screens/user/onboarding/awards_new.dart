import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoardingClasses/Achievement.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';

class AwardsNew extends StatefulWidget {
  const AwardsNew({super.key});

  @override
  State<AwardsNew> createState() => _AwardsNewState();
}

class _AwardsNewState extends State<AwardsNew> {
  int currentPage = 4;
  CommonWidgets commonWidgets = CommonWidgets();
  final OnboardingController controller = Get.find<OnboardingController>();
  String? docType;

  String? startDate;

  late TextEditingController awardController = TextEditingController();
  late TextEditingController issuerController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController startDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // If editing, fill data
    final index = controller.editingIndexAwards.value;
    if (index != null && index < controller.achievements.length) {
      final a = controller.achievements[index];
      awardController = TextEditingController(text: a.award);
      issuerController = TextEditingController(text: a.issuer);
      startDateController = TextEditingController(text: a.year);
      startDate = a.year;
      startDateController.text = startDate ?? '';
      descriptionController = TextEditingController(text: a.description);
    } else {
      controller.editingIndexAwards.value = null; // reset stale index
      awardController = TextEditingController();
      issuerController = TextEditingController();
      startDate = null;
      descriptionController = TextEditingController();
    }
  }

  void saveAward() {
    final awardObj = Achievement(
      award: awardController.text.trim(),
      issuer: issuerController.text.trim(),
      year: startDate!,
      description: descriptionController.text.trim(),
    );

    if (controller.editingIndexAwards.value != null) {
      controller.updateAwards(awardObj);
    } else {
      controller.addAwards(awardObj);
    }

    Get.toNamed(AppRoutes.AWARDS_NEW_PREVIEW);
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
                title: 'Award & Achievements',
                subtitle:
                    'Include all of your awards and achievements in this section.',
              ),
              const SizedBox(height: 30),
              commonWidgets.buildTextEntiresWithoutRed(
                title: 'Award',
                hint: 'Award Name',
                keyboardinput: TextInputType.text,
                controller: awardController,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildTextEntiresWithoutRed(
                title: 'Issuer',
                hint: 'Issuer',
                keyboardinput: TextInputType.text,
                controller: issuerController,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildDateEntires(
                context: context,
                title: 'Date',
                hint: 'Select',
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
              const SizedBox(height: 20),
              commonWidgets.buildPara(
                height: 200,
                controller: descriptionController,
                hint: 'Tell us about award',
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
                  if (awardController.text.trim().isEmpty ||
                      issuerController.text.trim().isEmpty ||
                      startDate == null ||
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
                  saveAward();
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
                      Get.toNamed(AppRoutes.SKILLS);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              commonWidgets.buildSkipper(),
            ],
          ),
        ),
      ),
    );
  }
}
