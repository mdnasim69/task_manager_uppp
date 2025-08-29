import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screen/EmailVerify_Screen.dart';
import 'package:task_manager/UI/Screen/Home.dart';
import 'package:task_manager/UI/Screen/SignUp_Screen.dart';
import 'package:task_manager/UI/controllers/auth_controller.dart';
import 'package:task_manager/UI/widget/background.dart';
import 'package:task_manager/UI/widget/massage.dart';
import 'package:task_manager/data/model/user_model.dart';
import 'package:task_manager/data/service/NetworkCaller.dart';
import 'package:task_manager/data/utils/URL.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
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
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 50,
                      child: Visibility(
                        visible:Loading==false,
                        replacement:const Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _onLogin();
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
                          child: const Text(
                            'Login',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            //
                            Navigator.pushNamed(context, EmailverifyScreen.name);
                            //
                          },
                          child: Text(
                            'Forgot password ' ,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        InkWell(
                          onTap: () {
                            //
                            Navigator.pushNamed(context, SignUpScreen.name);
                            //
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " Don't have account !",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onLogin() async {
    Loading = true;
    setState(() {});
    Map<String, dynamic> PostBody = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text
    };
    NetworkResponse response =
        await Networkcaller.postReqest(URLs.loginURL, PostBody);
    Loading = false;
    setState(() {});
    if (response.isSuccess) {
      String token= response.ResponseBody!['token'];
      UserModel userData= UserModel.fromJson(response.ResponseBody!['data']);
     await AuthController.saveuserData(token, userData);
      message(context, 'Login Success');
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.name, (predicate) => false);
    } else {
      print(response.ResponseBody);
      message( context,"${ response.errorMassage} ${response.ResponseBody} 12345");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
