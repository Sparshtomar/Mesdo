import 'package:get/get.dart';
import 'package:mesdo/screens/authentication/forgot_password.dart';
import 'package:mesdo/screens/user/onboarding/awards_achievements.dart';
import 'package:mesdo/screens/user/onboarding/awards_preview.dart';
import 'package:mesdo/screens/user/onboarding/interest.dart';
import 'package:mesdo/screens/user/onboarding/personal_information.dart';
import 'package:mesdo/screens/user/onboarding/professional_summary.dart';
import 'package:mesdo/screens/user/onboarding/qualification.dart';
import 'package:mesdo/screens/user/onboarding/qualification_preview.dart';
import 'package:mesdo/screens/user/onboarding/skills.dart';
import 'package:mesdo/screens/user/onboarding/upload_resume.dart';
import 'package:mesdo/screens/user/onboarding/work_exp_preview.dart';
import 'package:mesdo/screens/user/onboarding/work_experience.dart';
import 'app_routes.dart';
import 'package:mesdo/screens/authentication/welcome_screen.dart';
import 'package:mesdo/screens/authentication/login.dart';
import 'package:mesdo/screens/authentication/signup.dart';
import 'package:mesdo/screens/authentication/change_password.dart';

class AppPages {
  static final pages = [
    //AUTHENTICATION
    GetPage(name: AppRoutes.WELCOME_SCREEN, page: () => WelcomeScreen()),
    GetPage(name: AppRoutes.LOGIN, page: () => Login()),
    GetPage(name: AppRoutes.SIGNUP, page: () => Signup()),
    GetPage(name: AppRoutes.FORGOT_PASSWORD, page: () => ForgotPassword()),
    GetPage(name: AppRoutes.CHANGE_PASSWORD, page: () => ChangePassword()),

    //USER -> ONBOARDING 
    GetPage(name: AppRoutes.UPLOAD_RESUME, page: () => UploadResume()),
    GetPage(name: AppRoutes.PERSONAL_INFORAMATION, page: () => PersonalInformation()),
    GetPage(name: AppRoutes.PROFESSIONAL_SUMMARY, page: () => ProfessionalSummary()),
    GetPage(name: AppRoutes.QUALIFICATION, page: () => Qualification()),
    GetPage(name: AppRoutes.WORK_EXPERIENCE, page: () => WorkExperience()),
    GetPage(name: AppRoutes.AWARDS_ACHIEVEMENTS, page: () => AwardsAchievements()),
    GetPage(name: AppRoutes.INTEREST, page: () => Interest()),
    GetPage(name: AppRoutes.WORK_EXP_PREVIEW, page: () => WorkExpPreview()),
    GetPage(name: AppRoutes.AWARDS_PREVIEW, page: () => AwardsPreview()),
    GetPage(name: AppRoutes.QUALIFICATION_PREVIEW, page: () => QualificationPreview()),
    GetPage(name: AppRoutes.SKILLS, page: () => Skills()),
  ];
}
