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

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
CommonWidgets commonWidgets = CommonWidgets();
OnboardingController onboardingController = OnboardingController();

class _PersonalInformationState extends State<PersonalInformation> {
  String? selectedGender;
  String? selectedState;
  String? selectedCity;

  List<Map<String, String>> states = [];
  List<String> cities = [];

  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchStates();
  }

  Future<void> fetchStates() async {
    try {
      final response = await dio.get(
        'https://your-api-base-url.com/api/onboarding/states',
      );

      if (response.statusCode == 200) {
        setState(() {
          states = List<Map<String, String>>.from(
            response.data.map<Map<String, String>>(
              (state) => {
                "name": state["name"].toString(),
                "code": state["isoCode"].toString(),
              },
            ),
          );
        });
      } else {
        print('Failed to load states');
      }
    } catch (e) {
      print('Error fetching states: $e');
    }
  }

  Future<void> fetchCities(String stateName) async {
    try {
      // Find the ISO code for the selected state name
      final selected = states.firstWhere(
        (s) => s["name"] == stateName,
        orElse: () => {},
      );

      final stateCode = selected["code"];
      if (stateCode == null || stateCode.isEmpty) return;

      final response = await dio.get(
        'https://your-api-base-url.com/api/onboarding/$stateCode/cities',
      );

      if (response.statusCode == 200) {
        setState(() {
          cities = List<String>.from(response.data.map((city) => city['name']));
        });
      } else {
        print('Failed to load cities');
      }
    } catch (e) {
      print('Error fetching cities: $e');
    }
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
                controller: nameController,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildTextEntires(
                title: 'Email',
                hint: 'akhil.sharma@gmail.com',
                keyboardinput: TextInputType.emailAddress,
                controller: emailController,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildTextEntires(
                title: 'Phone Number',
                hint: '921XXXX123',
                keyboardinput: TextInputType.phone,
                controller: phoneController,
              ),
              const SizedBox(height: 20),
              commonWidgets.buildGenderDropdown(
                selectedGender: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              commonWidgets.buildStateDropdown(
                selectedState: selectedState,
                states: states,
                onChanged: (state) {
                  setState(() {
                    selectedState = state;
                    selectedCity = null;
                  });
                  if (state != null) fetchCities(state);
                },
              ),
              const SizedBox(height: 20),
              commonWidgets.buildCityDropdown(
                selectedCity: selectedCity,
                cities: cities,
                onChanged: (city) {
                  setState(() {
                    selectedCity = city;
                  });
                },
              ),
              const SizedBox(height: 30),
              commonWidgets.buildButton(
                text: 'Continue',
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                height: 44,
                width: 317,
                onPressed: () {
                  final name = nameController.text.trim();
                  final email = emailController.text.trim();
                  final phone = phoneController.text.trim();
                  final gender = selectedGender ?? '';
                  final state = selectedState ?? '';
                  final city = selectedCity ?? '';

                  // if (name.isEmpty ||
                  //     email.isEmpty ||
                  //     phone.isEmpty ||
                  //     gender.isEmpty ||
                  //     state.isEmpty ||
                  //     city.isEmpty) {
                  //   Get.snackbar(
                  //     'Missing Information',
                  //     'Please fill all fields before continuing.',
                  //     snackPosition: SnackPosition.BOTTOM,
                  //     backgroundColor: Colors.redAccent,
                  //     colorText: Colors.white,
                  //   );
                  //   return;
                  // }

                  onboardingController.name.value = name;
                  onboardingController.email.value = email;
                  onboardingController.phone.value = phone;
                  onboardingController.gender.value = gender;
                  onboardingController.state.value = state;
                  onboardingController.city.value = city;

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
