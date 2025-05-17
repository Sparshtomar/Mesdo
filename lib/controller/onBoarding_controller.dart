import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/controller/onBoardingClasses/Achievement.dart';
import 'package:mesdo/controller/onBoardingClasses/Experience.dart';
import 'package:mesdo/controller/onBoardingClasses/Qualifications.dart';

class OnboardingController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController taglineController = TextEditingController();
  TextEditingController aboutYouController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController interestsController = TextEditingController();

  final RxnString state = RxnString();
  final RxnString city = RxnString();
  final RxnString gender = RxnString();

  var dob = ''.obs;
  var skills = <String>[].obs;
  var interests = <String>[].obs;

  var qualifications = <Qualifications>[].obs;
  var workExperience = <Experience>[].obs;
  var Achievements = <Achievement>[].obs;

  var currentPage = 0.obs;
  var totalPage = 7;

  // New reactive lists for states and cities
  var states = <Map<String, String>>[].obs;
  var cities = <String>[].obs;

  var editingIndex = RxnInt(); // null means adding new, not editing
  Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchStates();
  }

  Future<void> fetchStates() async {
    try {
      final response = await dio.get(
        'https://your-api-base-url.com/api/onboarding/states',
      );

      if (response.statusCode == 200) {
        states.value = List<Map<String, String>>.from(
          response.data.map<Map<String, String>>(
            (state) => {
              "name": state["name"].toString(),
              "code": state["isoCode"].toString(),
            },
          ),
        );
      } else {
        print('Failed to load states');
      }
    } catch (e) {
      print('Error fetching states: $e');
    }
  }

  Future<void> fetchCities(String stateName) async {
    try {
      final selected = states.firstWhere(
        (s) => s["name"] == stateName,
        orElse: () => {},
      );

      final stateCode = selected["code"];
      if (stateCode == null || stateCode.isEmpty) {
        cities.clear();
        return;
      }

      final response = await dio.get(
        'https://your-api-base-url.com/api/onboarding/$stateCode/cities',
      );

      if (response.statusCode == 200) {
        cities.value = List<String>.from(
          response.data.map((city) => city['name']),
        );
      } else {
        print('Failed to load cities');
      }
    } catch (e) {
      print('Error fetching cities: $e');
    }
  }

  void setCurrentPage(int pageNumber) {
    currentPage.value = pageNumber;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "phoneNo": phoneController.text.trim(),
      "gender": gender.value,
      "dob": dob.value,
      "state": state.value,
      "city": city.value,
      "tagline": taglineController.text.trim(),
      "aboutYou": aboutYouController.text.trim(),
      "qualifications": qualifications.map((q) => q.toJson()).toList(),
      "workExperience": workExperience.map((w) => w.toJson()).toList(),
      "Achievements": Achievements.map((a) => a.toJson()).toList(),
      "Skills": skills.toList(),
      "interest": interests.toList(),
    };
  }

  void clearAll() {
    //for clearing fields
    nameController.text = '';
    emailController.text = '';
    phoneController.text = '';
    gender.value = null;
    dob.value = '';
    state.value = null;
    city.value = null;
    taglineController.text = '';
    aboutYouController.text = '';
    qualifications.value = [];
    workExperience.value = [];
    skills.value = [];
    Achievements.value = [];
    interests.value = [];
  }

  void updateForm(Map<String, dynamic> data) {
    //for updating any fields.
  }

  void addQualification(Qualifications q) {
    qualifications.add(q);
  }

  void updateQualification(Qualifications q) {
    if (editingIndex.value != null) {
      qualifications[editingIndex.value!] = q;
      editingIndex.value = null;
    }
  }

  void deleteQualification(int index) {
    qualifications.removeAt(index);
  }
}
