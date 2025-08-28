import 'package:flutter/material.dart';
import 'package:task_manager/UI/widget/TaskItem.dart';
import 'package:task_manager/UI/widget/background.dart';
import 'package:task_manager/data/model/TaskListByStatusModel.dart';

import '../../data/service/NetworkCaller.dart';
import '../../data/utils/URL.dart';

class Progresstask extends StatefulWidget {
  const Progresstask({super.key});

  @override
  State<Progresstask> createState() => _ProgressState();
}

class _ProgressState extends State<Progresstask> {
  bool Loading = false;
  TaskListByStatusModel? taskListByStatusModel;

  @override
  void initState() {
    _TaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Visibility(
          visible:Loading==false,
          replacement:Center(child:CircularProgressIndicator(),),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: taskListByStatusModel?.data?.length ?? 0,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) => TaskItem(
                id:taskListByStatusModel!.data![index],
                status:"Progress",
                taskListModel: taskListByStatusModel!.data![index],
                color: Colors.yellowAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _TaskList() async {
    Loading = true;
    setState(() {});
    NetworkResponse response = await Networkcaller.getReqest(
      URLs.NewTaskListURL('Progress'),
    );
    if (response.isSuccess) {
      taskListByStatusModel = TaskListByStatusModel.fromJson(
        response.ResponseBody!,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('fail')));
    }
    Loading = false;
    setState(() {});
  }
}
