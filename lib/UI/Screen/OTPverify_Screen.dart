import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screen/SetPassword_Screen.dart';
import 'package:task_manager/UI/widget/background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/service/NetworkCaller.dart';
import '../../data/utils/URL.dart';
import '../widget/massage.dart';

class OTPverifyScreen extends StatefulWidget {
  const OTPverifyScreen({super.key});
  static String name = '/otpVerify';

  @override
  State<OTPverifyScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<OTPverifyScreen> {
  final TextEditingController _OTPController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool Loading = false;
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
                  const SizedBox(height: 80),
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
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 16),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 45,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.green,
                      errorBorderColor: Colors.red,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: _OTPController,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    appContext: context,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    child: Visibility(
                      visible: Loading == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _OtpV();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromWidth(double.maxFinite),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Next'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _OtpV() async {
    Loading = true;
    setState(() {});
    NetworkResponse response = await Networkcaller.getReqest(
      URLs.OTPverifyURL(_OTPController.text.trim()),
    );
    Loading = false;
    setState(() {});
    if (response.isSuccess) {
      Navigator.pushNamed(context, SetPasswordScreen.name);
    } else {
      message(context, '${response.errorMassage} ,something went wrong');
    }
  }

  @override
  void dispose() {
    _OTPController.dispose();
    super.dispose();
  }
}
