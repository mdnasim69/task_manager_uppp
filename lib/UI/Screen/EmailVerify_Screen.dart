import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/UI/Screen/OTPverify_Screen.dart';
import 'package:task_manager/UI/Screen/SignUp_Screen.dart';
import 'package:task_manager/UI/widget/background.dart';

import '../../data/service/NetworkCaller.dart';
import '../../data/utils/URL.dart';
import '../widget/massage.dart';

class EmailverifyScreen extends StatefulWidget {
  const EmailverifyScreen({super.key});

  static String name = '/emailVerify';

  @override
  State<EmailverifyScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<EmailverifyScreen> {
  final TextEditingController _emailController = TextEditingController();
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
                      'A 6 digit code will be sent in your email',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your email address';
                      }
                      return null;
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
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
                            _emailV();
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
                  InkWell(
                    onTap: () {
                      //
                     // Navigator.pushNamed(context, SignUpScreen.name);
                      //
                      Get.toNamed(SignUpScreen.name);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " Don't have account !",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _emailV() async {
    Loading = true;
    setState(() {});
    NetworkResponse response = await Networkcaller.getReqest(
      URLs.EmailverifyURL(_emailController.text.trim()),
    );
    Loading = false;
    setState(() {});
    if (response.isSuccess) {
     // Navigator.pushNamed(context, OTPverifyScreen.name);
      Get.toNamed(OTPverifyScreen.name);
    } else {
      message(context, '${response.errorMassage} ,fail try again');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
