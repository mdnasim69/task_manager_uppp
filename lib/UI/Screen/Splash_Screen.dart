import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screen/Home.dart';
import 'package:task_manager/UI/Screen/Login_Screen.dart';
import 'package:task_manager/UI/controllers/auth_controller.dart';
import 'package:task_manager/UI/widget/background.dart';
import 'package:task_manager/UI/widget/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String name = '/';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    ChangeScreen();
  }

  Future<void> ChangeScreen() async {
    await Future.delayed(const Duration(seconds: 3));
   bool IsLogin = await AuthController.IsLogin();
   if(IsLogin){
     Navigator.pushNamedAndRemoveUntil(context, HomeScreen.name, (predicate)=>false);
   }else{Navigator.pushNamedAndRemoveUntil(
       context, LoginScreen.name, (predicate) => false);}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.name, (predicate) => false);
          },
          child: const logo(),
        ),
      ),
    );
  }
}
