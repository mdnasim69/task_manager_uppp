import 'package:flutter/material.dart';
import '../../data/model/TaskListByStatusModel.dart';
import '../../data/service/NetworkCaller.dart';
import '../../data/utils/URL.dart';
import '../widget/TaskItem.dart';
import '../widget/background.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {

  bool Loading =false;
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
        child: Visibility(visible:Loading==false,
        replacement:Center(child:CircularProgressIndicator(),),
          child: RefreshIndicator(onRefresh:_TaskList,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: taskListByStatusModel?.data?.length??0,
                shrinkWrap: true,
                primary: true,
                itemBuilder: (context, index) =>  TaskItem(
                  id:taskListByStatusModel!.data![index],              status:'Completed',
                  color: Colors.blue,taskListModel:taskListByStatusModel!.data![index],
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
      URLs.NewTaskListURL('Completed'),
    );
    if (response.isSuccess) {
      taskListByStatusModel = TaskListByStatusModel.fromJson(
        response.ResponseBody!,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('fail')));
    }
    Loading = false;
    setState(() {});
  }

}