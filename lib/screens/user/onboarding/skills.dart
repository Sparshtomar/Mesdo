import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';

class Skills extends StatefulWidget {
  const Skills({super.key});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  int currentPage = 5;
  final CommonWidgets commonWidgets = CommonWidgets();
  final OnboardingController controller = Get.find<OnboardingController>();

  List<String> skills = [];
  final TextEditingController skillsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    skills = List<String>.from(controller.skills);
  }

  void _addSkill(String skill) {
    final trimmed = skill.trim();
    if (trimmed.isEmpty || skills.contains(trimmed)) return;

    setState(() {
      skills.add(trimmed);
      controller.skills.value = skills; // Sync with GetX controller
    });
  }

  void _removeSkill(String skill) {
    setState(() {
      skills.remove(skill);
      controller.skills.value = skills;
    });
  }

  @override
  void dispose() {
    skillsController.dispose();
    super.dispose();
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
              const SizedBox(height: 20),
              commonWidgets.buildHeader(
                title: 'Skills / Specialization',
                subtitle:
                    'Include all of your skills and specialization in this section.',
              ),
              const SizedBox(height: 20),

              commonWidgets.buildSkillInputChips(
                controller: skillsController,
                skills: skills,
                onAdd: _addSkill,
                onDelete: _removeSkill,
              ),

              const SizedBox(height: 40),

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
                      // Data already in controller.skillsList
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
