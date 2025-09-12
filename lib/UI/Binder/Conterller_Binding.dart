import 'package:get/get.dart';
import 'package:task_manager/UI/controllers/Login_Controller.dart';
import 'package:task_manager/UI/controllers/NewTaskController.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>LogInController());
    Get.put(NewTaskController());
  }
}