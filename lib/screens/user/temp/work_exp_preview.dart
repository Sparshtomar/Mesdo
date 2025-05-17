import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';

class WorkExpPreview extends StatefulWidget {
  const WorkExpPreview({super.key});

  @override
  State<WorkExpPreview> createState() => _WorkExpPreviewState();
}

class _WorkExpPreviewState extends State<WorkExpPreview> {
  CommonWidgets commonWidgets = CommonWidgets();
  final onboardingController = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    final experiences = onboardingController.workExperience;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonWidgets.buildHeader(
                title: 'Work Experience',
                subtitle: 'Here’s what you’ve added so far:',
              ),
              const SizedBox(height: 20),

              // List of experiences
              Expanded(
                child:
                    experiences.isEmpty
                        ? const Text("No experiences added.")
                        : ListView.separated(
                          itemCount: experiences.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            final exp = experiences[index];
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (exp.jobTitle != null)
                                    Text(
                                      exp.jobTitle!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  if (exp.hospital != null) Text(exp.hospital!),
                                  if (exp.location != null) Text(exp.location!),
                                  if (exp.startDate != null ||
                                      exp.endDate != null)
                                    Text(
                                      "${exp.startDate ?? ''} - ${exp.currentlyWorking ? 'Present' : (exp.endDate ?? '')}",
                                    ),
                                  if (exp.description != null)
                                    const SizedBox(height: 8),
                                  if (exp.description != null)
                                    Text(exp.description!),
                                ],
                              ),
                            );
                          },
                        ),
              ),

              const SizedBox(height: 20),

              // Add More Experience Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Get.toNamed(
                    //   AppRoutes.WORK_EXPERIENCE,
                    // ); // or use Get.to(WorkExperience())
                    Get.back(result: 'goToWorkExperience');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add More Experience"),
                ),
              ),

              const SizedBox(height: 20),

              // Continue/Skip Buttons
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
                     // Get.toNamed(AppRoutes.AWARDS_PREVIEW);
                    },
                  ),
                  commonWidgets.buildButton(
                    text: 'Continue',
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    height: 44,
                    width: 140,
                    onPressed: () {
                    //  Get.toNamed(AppRoutes.AWARDS_PREVIEW);
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
