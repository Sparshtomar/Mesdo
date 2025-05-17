import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoardingClasses/Experience.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'package:mesdo/screens/user/onboarding/common_widgets.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

// Local model to hold dynamic form fields
class WorkExperienceInputModel {
  String? location;
  bool? currentlyWorking;

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
}

class _WorkExperienceState extends State<WorkExperience> {
  List<WorkExperienceInputModel> inputs = [WorkExperienceInputModel()];
  CommonWidgets commonWidgets = CommonWidgets();
  final OnboardingController onboardingController =
      Get.find<OnboardingController>();

  void addNewInput() {
    setState(() {
      inputs.add(WorkExperienceInputModel());
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
                title: 'Work Experience',
                subtitle:
                    'Include all of your relevant experience and dates in this section',
              ),
              SizedBox(height: 30),
              ...List.generate(inputs.length, (index) {
                final item = inputs[index];
                return Column(
                  children: [
                    commonWidgets.buildTextEntiresWithoutRed(
                      title: 'Job Title',
                      hint: 'Job Title',
                      keyboardinput: TextInputType.text,
                      controller: item.titleController,
                    ),
                    const SizedBox(height: 20),
                    commonWidgets.buildTextEntiresWithoutRed(
                      title: 'Hospital/Clinic',
                      hint: 'Hospital/Clinic',
                      keyboardinput: TextInputType.text,
                      controller: item.hospitalController,
                    ),
                    const SizedBox(height: 20),
                    commonWidgets.buildQualificationDropdown(
                      headline: 'Location',
                      selectedValue: item.location,
                      onChanged: (newValue) {
                        setState(() {
                          item.location = newValue == 'None' ? null : newValue;
                        });
                      },
                      items: ['Delhi', 'Mumbai', 'Pune', 'None'],
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
                            controller: item.startDateController,
                            readOnly: false,
                            ontap: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                item.startDateController.text =
                                    pickedDate.toString().split(' ')[0];
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
                            controller: item.endDateController,
                            readOnly: item.currentlyWorking ?? false,
                            ontap:
                                item.currentlyWorking == true
                                    ? null
                                    : () async {
                                      final pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );
                                      if (pickedDate != null) {
                                        item.endDateController.text =
                                            pickedDate.toString().split(' ')[0];
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
                          value: item.currentlyWorking ?? false,
                          onChanged: (bool? value) {
                            setState(() {
                              item.currentlyWorking = value ?? false;
                              if (value == true) {
                                item.endDateController.clear();
                              }
                              FocusScope.of(
                                context,
                              ).unfocus(); // dismiss keyboard
                            });
                          },
                        ),
                        Text('Present'),
                      ],
                    ),

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
                  'Add Work Experience',
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
                    //  Get.toNamed(AppRoutes.AWARDS_ACHIEVEMENTS);
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
                      bool isAllFieldsEmpty(WorkExperienceInputModel item) {
                        return item.titleController.text.trim().isEmpty &&
                            item.hospitalController.text.trim().isEmpty &&
                            (item.location == null ||
                                item.location!.trim().isEmpty) &&
                            item.startDateController.text.trim().isEmpty &&
                            item.endDateController.text.trim().isEmpty &&
                            item.descriptionController.text.trim().isEmpty &&
                            !(item.currentlyWorking ?? false);
                      }

                      bool isAnyFieldEmpty(WorkExperienceInputModel item) {
                        return item.titleController.text.trim().isEmpty ||
                            item.hospitalController.text.trim().isEmpty ||
                            item.location == null ||
                            item.location!.trim().isEmpty ||
                            item.startDateController.text.trim().isEmpty ||
                            (!(item.currentlyWorking ?? false) &&
                                item.endDateController.text.trim().isEmpty) ||
                            item.descriptionController.text.trim().isEmpty;
                      }

                      final incompleteEntries =
                          inputs
                              .where(
                                (item) =>
                                    !isAllFieldsEmpty(item) &&
                                    isAnyFieldEmpty(item),
                              )
                              .toList();

                      if (incompleteEntries.isNotEmpty) {
                        Get.snackbar(
                          "Incomplete Entry",
                          "Please either fill **all** fields for each experience or leave it completely empty.",
                          backgroundColor: Colors.red.shade100,
                          colorText: Colors.red.shade800,
                        );
                        return;
                      }

                      onboardingController.workExperience.value =
                          inputs
                              .where((item) => !isAllFieldsEmpty(item))
                              .map(
                                (item) => Experience(
                                  jobTitle: item.titleController.text.trim(),
                                  hospital: item.hospitalController.text.trim(),
                                  location: item.location!.trim(),
                                  startDate:
                                      item.startDateController.text.trim(),
                                  endDate:
                                      (item.currentlyWorking ?? false)
                                          ? null
                                          : item.endDateController.text.trim(),
                                  description:
                                      item.descriptionController.text.trim(),
                                  currentlyWorking:
                                      item.currentlyWorking ?? false,
                                ),
                              )
                              .toList();

                     // Get.toNamed(AppRoutes.AWARDS_ACHIEVEMENTS);
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
