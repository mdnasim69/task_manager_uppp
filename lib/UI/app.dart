import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/UI/Binder/Conterller_Binding.dart';
import 'package:task_manager/UI/Screen/AddNewTask_scree.dart';
import 'package:task_manager/UI/Screen/EmailVerify_Screen.dart';
import 'package:task_manager/UI/Screen/Home.dart';
import 'package:task_manager/UI/Screen/Login_Screen.dart';
import 'package:task_manager/UI/Screen/OTPverify_Screen.dart';
import 'package:task_manager/UI/Screen/SetPassword_Screen.dart';
import 'package:task_manager/UI/Screen/SignUp_Screen.dart';
import 'package:task_manager/UI/Screen/Splash_Screen.dart';
import 'package:task_manager/UI/Screen/UpdateProfileScreen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  static GlobalKey<NavigatorState> nevigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinding(),
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: nevigatorKey,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == SplashScreen.name) {
          widget = const SplashScreen();
        } else if (settings.name == LoginScreen.name) {
          widget = const LoginScreen();
        } else if (settings.name == SignUpScreen.name) {
          widget = const SignUpScreen();
        } else if (settings.name == EmailverifyScreen.name) {
          widget = const EmailverifyScreen();
        } else if (settings.name == HomeScreen.name) {
          widget = const HomeScreen();
        } else if (settings.name == OTPverifyScreen.name) {
          widget = const OTPverifyScreen();
        } else if (settings.name == SetPasswordScreen.name) {
          widget = const SetPasswordScreen();
        } else if (settings.name == AddnewtaskScree.name) {
          widget = const AddnewtaskScree();
        } else if (settings.name == Updateprofilescreen.name) {
          widget = const Updateprofilescreen();
        }
        return MaterialPageRoute(builder: (_) => widget);
      },
    );
  }
}
