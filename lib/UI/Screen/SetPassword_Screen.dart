import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screen/Login_Screen.dart';
import 'package:task_manager/UI/widget/background.dart';

import '../../data/service/NetworkCaller.dart';
import '../../data/utils/URL.dart';
import '../widget/massage.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  static String name = '/setPass';

  @override
  State<SetPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SetPasswordScreen> {
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _ConfirmPasswordController =
      TextEditingController();
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
                      'Get Statrted',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      } else if (value.length < 6) {
                        return ' password should be at least 6 characters';
                      }
                      return null;
                    },
                    controller: _PasswordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (String? value) {
                      if (value != _PasswordController.text) {
                        return 'Your password must be same';
                      }
                      return null;
                    },
                    controller: _ConfirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: false,
                    decoration: const InputDecoration(
                      hintText: 'Confirm password',
                    ),
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
                            _SetPass();
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
                        child: const Text('Login'),
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

  Future<void> _SetPass() async {
    Loading = true;
    setState(() {});
    Map<String, dynamic> PostBody = {
      "email": URLs.Email.toString(),
      "OTP": URLs.OTP.toString(),
      "password": _PasswordController.text,
    };
    NetworkResponse response = await Networkcaller.postReqest(
      URLs.SetPassURL,
      PostBody,
    );

    if (response.isSuccess && response.ResponseBody!['status']=='success') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.name,
        (predicate) => false,
      );
      message(context, 'Password Changed');
    } else {
      message(context, '${response.errorMassage} ,something went wrong ${URLs.Email.toString()} ${URLs.OTP.toString()}');
      Loading = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _PasswordController.dispose();
    _ConfirmPasswordController.dispose();
    super.dispose();
  }
}
