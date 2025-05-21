import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';

class AwardsnewPreview extends StatefulWidget {
  const AwardsnewPreview({super.key});

  @override
  State<AwardsnewPreview> createState() => _AwardsnewPreviewState();
}

class _AwardsnewPreviewState extends State<AwardsnewPreview> {
  int currentPage = 4;
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
                title: 'Awards & Acheivements',
                subtitle:
                    'Include all of your awards & acheivements in this section.',
              ),
              const SizedBox(height: 30),
              Obx(
                () => Column(
                  children: List.generate(controller.achievements.length, (
                    index,
                  ) {
                    final a = controller.achievements[index];
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
                                  '${a.award}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Awarded by - ${a.issuer} | ${a.year}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 4),
                                Text(a.description),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.editingIndexAwards.value = index;
                                  Get.toNamed(AppRoutes.AWARDS_NEW);
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
                                  controller.deleteAwards(index);
                                  if (controller.editingIndexAwards.value !=
                                          null &&
                                      controller.editingIndexAwards.value! >=
                                          controller.achievements.length) {
                                    controller.editingIndexAwards.value = null;
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
                  controller.editingIndexAwards.value = null;
                  Get.toNamed(AppRoutes.AWARDS_NEW);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.blue),
                    SizedBox(width: 4),
                    Text(
                      'Add Awards & Achievements',
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
