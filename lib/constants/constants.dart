import 'package:flutter/material.dart';

const white = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

const black = MaterialColor(
  0xFF333333,
  <int, Color>{
    50: Color(0xFF333333),
    100: Color(0xFF333333),
    200: Color(0xFF333333),
    300: Color(0xFF333333),
    400: Color(0xFF333333),
    500: Color(0xFF333333),
    600: Color(0xFF333333),
    700: Color(0xFF333333),
    800: Color(0xFF333333),
    900: Color(0xFF333333),
  },
);

class AppColors{
  static Color blue = const Color(0xFF246BFD);
  static Color grey = const Color(0xFF959292);
  static Color lightGrey = const Color(0xFF959292);
}

class Strings{

    static const String welcome = "Welcome Back";
    static const String login = "Login to Your Account";
    static const String create = "Create An Account";
    static const String appTitle = "Printzkart";
    static const String forgotPass = "Forgot Your Password?";
    static const String notHaveAccount = "Don't have an account?";
    static const String alreadyHaveAccount = "Already have an account?";
    static const String signIn = "Sign In";
    static const String signUp = "Sign Up";

    static const String playStoreLink = "https://play.google.com/store/apps/details?id=com.example.printzkart";


    static const String apiKey = "AIzaSyCAI1yyhlNstjfL3fWxfPub_WJXR7AQDHE";
    static const String phoneNo = "9731755782";
    static const String phoneNo2 = "6360283627";

}

class AppInfo {
  static const String appName = "Printzkart";
  static const String playStoreLink = "https://play.google.com/store/apps/details?id=com.example.wallpaperapp";

}

class Images{

  static String logo = "assets/images/logos/logo.png";

  static String forgotPassImageLight = "assets/images/Forgot_password_light.png";
  static String forgotPassImageDark= "assets/images/Forgot_password_dark.png";

  static String signInLight= "assets/images/signin(light).png";
  static String signInDark= "assets/images/signin(dark).png";

  static String signupLight= "assets/images/signup(light).png";
  static String signupDark= "assets/images/signup(dark).png";

  static String success = "assets/images/success.png";

  static String google = "assets/images/logos/Google_logo.png";
  static String facebook = "assets/images/logos/Facebook_logo.png";
  static String apple = "assets/images/logos/Apple_logo.png";
}

class AppIcons{
  static String model = "assets/icons/3d_view.png";
  static String modelActive = "assets/icons/3d_view_active.png";
  static String printer = "assets/icons/3d_printer.png";
  static String printerActive = "assets/icons/3d_printer_active.png";
  static String filament = "assets/icons/3d_printing_filament.png";
  static String filamentActive = "assets/icons/3d_printing_filament_active.png";
  static String videos = "assets/icons/videos.png";
  static String videosActive = "assets/icons/videos_active.png";
  static String profile = "assets/icons/profile.png";
  static String profileActive = "assets/icons/profile_active.png";

  static String download = "assets/images/icons/download.png";
  static String feedback = "assets/images/icons/feedback.png";
}

class Privacy {
  static String privacyPolicy = "";
}