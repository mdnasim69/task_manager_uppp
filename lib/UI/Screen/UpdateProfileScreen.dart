import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/UI/controllers/auth_controller.dart';
import 'package:task_manager/UI/widget/TaskAppBar.dart';
import 'package:task_manager/UI/widget/background.dart';
import 'package:task_manager/UI/widget/massage.dart';
import 'package:task_manager/data/service/NetworkCaller.dart';
import 'package:task_manager/data/utils/URL.dart';
class Updateprofilescreen extends StatefulWidget {
  const Updateprofilescreen({super.key});

  static String name = '/UpdateProfileScreen';

  @override
  State<Updateprofilescreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Updateprofilescreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  XFile? Image;
  bool loading = false;

  @override
  void initState() {
    _emailController.text = AuthController.userData!.email!;
    _firstNameController.text = AuthController.userData!.firstName!;
    _lastNameController.text = AuthController.userData!.lastName!;
    _mobileController.text = AuthController.userData!.mobile!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskAppBar(UpdateProfileScreen: false),
      body: Background(
        child: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Update Profile',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _ImagePicker,
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 56,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: const Text('Photo'),
                            ),
                            Text(
                              Image == null
                                  ? '  No Item selected'
                                  : Image!.name,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      enabled: false,
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Email'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                      controller: _firstNameController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: false,
                      decoration: const InputDecoration(hintText: 'First Name'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                      controller: _lastNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Last Name'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter your Mobile number';
                        }
                        return null;
                      },
                      controller: _mobileController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Mobile'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 50,
                      child: Visibility(
                        visible:loading==false,
                        replacement:Center(child:CircularProgressIndicator(),),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _UpdateProfile();
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
                          child: const Text('Update'),
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
      ),
    );
  }

  Future<void> _ImagePicker() async {
    ImagePicker image = ImagePicker();
    XFile? pickedImage = await image.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Image = pickedImage;
      setState(() {});
    }
  }

  Future<void> _UpdateProfile() async {
    loading = true;
    setState(() {});
    Map<String, dynamic> PostBody = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };
    if (Image != null) {
      List<int> ImageByte = await Image!.readAsBytes();
      PostBody["photo"] = base64Encode(ImageByte);
    }
    if (_passwordController.text.isNotEmpty) {
      PostBody["password"] = _passwordController.text;
    }

    NetworkResponse response = await Networkcaller.postReqest(
      URLs.UpdateProfileURL,
      PostBody,
    );
    loading = false;
    setState(() {});
    if (response.isSuccess) {
      _passwordController.clear();
      message(context, 'Updated');
    } else {
      message(context, 'fail ! try again');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }
}
