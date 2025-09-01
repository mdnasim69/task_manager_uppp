import 'package:flutter/material.dart';
import '../../data/model/TaskListByStatusModel.dart';
import '../../data/service/NetworkCaller.dart';
import '../../data/utils/URL.dart';
import '../widget/TaskItem.dart';
import '../widget/background.dart';

class Cancelled extends StatefulWidget {
  const Cancelled({super.key});

  @override
  State<Cancelled> createState() => _NewTaskState();
}

class _NewTaskState extends State<Cancelled> {
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
      body: RefreshIndicator(
        onRefresh: _TaskList,
        child: Background(
          child: Visibility(
            visible: Loading == false,
            replacement: Center(child: CircularProgressIndicator()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: taskListByStatusModel?.data?.length ?? 0,
                shrinkWrap: true,
                primary: true,
                itemBuilder: (context, index) => TaskItem(
                  id: taskListByStatusModel!.data![index].sId.toString(),
                  status: 'Cancelled',
                  color: Colors.redAccent,
                  taskListModel: taskListByStatusModel!.data![index],
                ),
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
      URLs.NewTaskListURL('Cancelled'),
    );
    if (response.isSuccess) {
      taskListByStatusModel = TaskListByStatusModel.fromJson(
        response.ResponseBody!,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Cancelled')));
    }
    Loading = false;
    setState(() {});
  }
}
