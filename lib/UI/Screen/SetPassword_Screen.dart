import 'package:flutter/material.dart';
import 'package:task_manager/UI/widget/background.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});
  static String name = '/setPass';

  @override
  State<SetPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SetPasswordScreen> {
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _ConfirmPasswordController = TextEditingController();
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
                      'Get Statrted',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _PasswordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _ConfirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Confirm password',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {

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
                        'Login',
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
    _PasswordController.dispose();
    _ConfirmPasswordController.dispose();
    super.dispose();
  }
}
