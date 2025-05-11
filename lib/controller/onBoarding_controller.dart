import 'package:get/get.dart';
import 'package:mesdo/controller/onBoardingClasses/Achievement.dart';
import 'package:mesdo/controller/onBoardingClasses/Experience.dart';
import 'package:mesdo/controller/onBoardingClasses/Qualifications.dart';

class OnboardingController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var gender = ''.obs;
  var dob = ''.obs;
  var state = ''.obs;
  var city = ''.obs;
  var tagline = ''.obs;
  var aboutYou = ''.obs;

  var qualifications = <Qualifications>[].obs;
  var workExperience = <Experience>[].obs;
  var skills = <String>[].obs;
  var Achievements = <Achievement>[].obs;
  var interests = <String>[].obs;

  Map<String, dynamic> toJson() {
    return {
      "name": name.value,
      "email": email.value,
      "phoneNo": phone.value,
      "gender": gender.value,
      "dob": dob.value,
      "state": state.value,
      "city": city.value,
      "tagline": tagline.value,
      "aboutYou": aboutYou.value,
      "qualifications": qualifications.map((q) => q.toJson()).toList(),
      "workExperience": workExperience.map((w) => w.toJson()).toList(),
      "Skills": skills,
      "Achievements": Achievements.map((a) => a.toJson()).toList(),
      "interest": interests,
    };
  }

  void clearAll() {
    //for clearing fields
    name.value = '';
    email.value = '';
    phone.value = '';
    gender.value = '';
    dob.value = '';
    state.value = '';
    city.value = '';
    tagline.value = '';
    aboutYou.value = '';
    qualifications.value = [];
    workExperience.value = [];
    skills.value = [];
    Achievements.value = [];
    interests.value = [];
  }

  void updateForm(Map<String, dynamic> data) {
    //for updating any fields.
  }
}
