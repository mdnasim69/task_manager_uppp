import 'package:flutter/material.dart';
import 'package:task_manager/UI/widget/TaskItem.dart';
import 'package:task_manager/UI/widget/background.dart';
import 'package:task_manager/UI/widget/statusCount.dart';
import 'package:task_manager/data/model/TaskCountByStatusModel.dart';
import 'package:task_manager/data/model/TaskListByStatusModel.dart';
import 'package:task_manager/data/service/NetworkCaller.dart';
import 'package:task_manager/data/utils/URL.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool Loading = false;
  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListByStatusModel? taskListByStatusModel;

  @override
  void initState() {
    _TaskCount();
    _TaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(onRefresh: _TaskList,
        child: Background(
          child: Visibility(
            visible: Loading == false,
            replacement: Center(child: CircularProgressIndicator()),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 92,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: true,
                        itemCount: taskCountByStatusModel?.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return StatusCount(
                            title: taskCountByStatusModel!.data![index].sId ?? '',
                            count: taskCountByStatusModel!.data![index].sum
                                .toString(),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: taskListByStatusModel?.data?.length ?? 0,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) => TaskItem(
                        id: taskListByStatusModel!.data![index].sId.toString(),
                        status:'New',
                        color: Colors.green,
                        taskListModel: taskListByStatusModel!.data![index],
                      ),
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

  Future<void> _TaskCount() async {
    Loading = true;
    setState(() {});
    NetworkResponse response = await Networkcaller.getReqest(
      URLs.taskStatusCountURL,
    );
    if (response.isSuccess) {
      taskCountByStatusModel = TaskCountByStatusModel.fromJson(
        response.ResponseBody!,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('fail 2')));
    }
    Loading = false;
    setState(() {});
  }

  Future<void> _TaskList() async {
    Loading = true;
    setState(() {});
    NetworkResponse response = await Networkcaller.getReqest(
      URLs.NewTaskListURL('New'),
    );
    if (response.isSuccess) {
      taskListByStatusModel = TaskListByStatusModel.fromJson(
        response.ResponseBody!,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('fail 1')));
    }
    Loading = false;
    setState(() {});
  }
}
