import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screen/Home.dart';
import 'package:task_manager/data/service/NetworkCaller.dart';
import 'package:task_manager/data/utils/URL.dart';
import '../widget/TaskAppBar.dart';
import '../widget/background.dart';
import '../widget/massage.dart';

class AddnewtaskScree extends StatefulWidget {
  const AddnewtaskScree({super.key});

  static String name = '/addNewTask';

  @override
  State<AddnewtaskScree> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AddnewtaskScree> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskAppBar(UpdateProfileScreen: true),
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
                    const SizedBox(height: 80),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Add New Task',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter your title';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: 'title'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter your description';
                        }
                        return null;
                      },
                      maxLines: 8,
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Description',
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 50,
                      child: Visibility(
                        visible:Loading==false,
                        replacement:Center(child:CircularProgressIndicator(),),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _addNewTAsk();
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
                          child: const Text('Add'),
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

  Future<void> _addNewTAsk() async {
    Loading = true;
    setState(() {});
    Map<String, dynamic> RequestBody = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New",
    };

    NetworkResponse response = await Networkcaller.postReqest(
      URLs.createTaskURL,
      RequestBody,
    );
    Loading=false;
    setState(() {});
    if(response.isSuccess){
      _clearField();
      message(context, 'Login Success');
      Navigator.pushNamed(context, HomeScreen.name);
    }else{
      message(context, 'Login failed! try again');
    }
  }

_clearField(){
    _titleController.clear();
    _descriptionController.clear();
}
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
