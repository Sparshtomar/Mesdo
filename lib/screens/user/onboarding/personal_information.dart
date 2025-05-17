import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';
import 'package:mesdo/routes/app_routes.dart';
import 'common_widgets.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  int currentPage = 0;
  CommonWidgets commonWidgets = CommonWidgets();
  final OnboardingController onboardingController =
      Get.find<OnboardingController>();

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
                title: 'Personal Information',
                subtitle:
                    'Include all of your relevant experience and dates in this section.',
              ),
              const SizedBox(height: 30),
              commonWidgets.buildTextEntires(
                title: 'Name',
                hint: 'Akhil Sharma',
                keyboardinput: TextInputType.text,
                controller: onboardingController.nameController,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildTextEntires(
                title: 'Email',
                hint: 'akhil.sharma@gmail.com',
                keyboardinput: TextInputType.emailAddress,
                controller: onboardingController.emailController,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildTextEntires(
                title: 'Phone Number',
                hint: '921XXXX123',
                keyboardinput: TextInputType.phone,
                controller: onboardingController.phoneController,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildGenderDropdown(
                selectedGender: onboardingController.gender.value,
                onChanged: (newValue) {
                  onboardingController.gender.value = newValue!;
                },
              ),
              const SizedBox(height: 20),

              /// States dropdown wrapped in Obx
              Obx(
                () => commonWidgets.buildStateDropdown(
                  selectedState: onboardingController.state.value,
                  states: onboardingController.states,
                  onChanged: (newState) {
                    onboardingController.state.value = newState!;
                    onboardingController.city.value = null;
                    onboardingController.fetchCities(newState);
                  },
                ),
              ),
              const SizedBox(height: 20),

              /// Cities dropdown wrapped in Obx
              Obx(
                () => commonWidgets.buildCityDropdown(
                  selectedCity: onboardingController.city.value,
                  cities: onboardingController.cities,
                  onChanged: (newCity) {
                    onboardingController.city.value = newCity!;
                  },
                ),
              ),
              const SizedBox(height: 30),
              commonWidgets.buildButton(
                text: 'Continue',
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                height: 44,
                width: 317,
                onPressed: () {
                  final name = onboardingController.nameController.text.trim();
                  final email =
                      onboardingController.emailController.text.trim();
                  final phone =
                      onboardingController.phoneController.text.trim();
                  final gender = onboardingController.gender.value;
                  final state = onboardingController.state.value;
                  final city = onboardingController.city.value;

                  // if (name.isEmpty ||
                  //     email.isEmpty ||
                  //     phone.isEmpty ||
                  //     gender == null ||
                  //     state == null ||
                  //     city == null) {
                  //   Get.snackbar(
                  //     'Missing Information',
                  //     'Please fill all fields before Saving.',
                  //     snackPosition: SnackPosition.BOTTOM,
                  //     backgroundColor: Colors.redAccent,
                  //     colorText: Colors.white,
                  //   );
                  //   return;
                  // }

                  Get.toNamed(AppRoutes.PROFESSIONAL_SUMMARY);
                  //print('$name, $email, $phone, $gender, $state, $city');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
