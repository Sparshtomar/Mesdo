import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';

class QualificationsnewPrev extends StatefulWidget {
  const QualificationsnewPrev({super.key});

  @override
  State<QualificationsnewPrev> createState() => _QualificationsnewPrevState();
}

class _QualificationsnewPrevState extends State<QualificationsnewPrev> {
  int currentPage = 2;
  CommonWidgets commonWidgets = CommonWidgets();
  final OnboardingController controller = Get.find<OnboardingController>();

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
              commonWidgets.buildProgress(currentPage: currentPage),
              SizedBox(height: 20),
              commonWidgets.buildHeader(
                title: 'Qualifications',
                subtitle: 'Include all of your qualifications in this section.',
              ),
              const SizedBox(height: 30),
              Obx(
                () => Column(
                  children: List.generate(controller.qualifications.length, (
                    index,
                  ) {
                    final q = controller.qualifications[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  q.university,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${q.course} • ${q.specialization} - ${q.passingYear}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 4),
                                Text('${q.description}'),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.editingIndex.value = index;
                                  Get.toNamed(AppRoutes.QUALIFICATION_NEW);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/edit.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.deleteQualification(index);
                                  if (controller.editingIndex.value != null &&
                                      controller.editingIndex.value! >=
                                          controller.qualifications.length) {
                                    controller.editingIndex.value = null;
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/delete.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  controller.editingIndex.value = null;
                  Get.toNamed(AppRoutes.QUALIFICATION_NEW);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.blue),
                    SizedBox(width: 4),
                    Text(
                      'Add Qualification',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
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
