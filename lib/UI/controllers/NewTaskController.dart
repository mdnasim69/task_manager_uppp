import 'package:get/get.dart';
import 'package:task_manager/data/model/TaskListByStatusModel.dart';
import 'package:task_manager/data/model/TaskListModel.dart';

import '../../data/model/user_model.dart';
import '../../data/service/NetworkCaller.dart';
import '../../data/utils/URL.dart';
import '../Screen/Home.dart';
import 'auth_controller.dart';

class NewTaskController extends GetxController {
  TaskListByStatusModel? taskListByStatusModel;
  List<TaskListModel> get taskList =>taskListByStatusModel?.data??[];
  bool _Loading = false;
  bool get Loading => _Loading;
  String _errorMessage = "Something went wrong";

  String get errorMessage => _errorMessage;
  bool IsSucess = false;

  Future<bool> GetTask() async {
    _Loading = true;
    update();
    NetworkResponse response = await Networkcaller.getReqest(
      URLs.NewTaskListURL('New'),
    );

    if (response.isSuccess) {
      taskListByStatusModel =TaskListByStatusModel.fromJson(response.ResponseBody!);
      _errorMessage = "";
      IsSucess = true;
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   HomeScreen.name,
      //   (predicate) => false,
      // );
    } else {
      _errorMessage = response.errorMassage;
    }
    _Loading = false;
    update();
    return IsSucess;
  }
}
