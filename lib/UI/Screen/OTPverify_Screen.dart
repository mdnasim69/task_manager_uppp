import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screen/SetPassword_Screen.dart';
import 'package:task_manager/UI/widget/background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPverifyScreen extends StatefulWidget {
  const OTPverifyScreen({super.key});
  static String name = '/otpVerify';

  @override
  State<OTPverifyScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<OTPverifyScreen> {
  final TextEditingController _OTPController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Verify your email',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'A 6 digit has been be sent in your email',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.green,
                      errorBorderColor: Colors.red,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    controller: _OTPController,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    appContext: context,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SetPasswordScreen.name);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromWidth(double.maxFinite),
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Next',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _OTPController.dispose();
    super.dispose();
  }
}
