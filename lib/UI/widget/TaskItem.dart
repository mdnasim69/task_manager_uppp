import 'package:flutter/material.dart';
import 'package:task_manager/data/model/TaskListModel.dart';

import '../../data/service/NetworkCaller.dart';
import '../../data/utils/URL.dart';
import 'massage.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.color,
    required this.taskListModel,
    required this.status,
    required this.id,
  });

  final Color color;
  final TaskListModel taskListModel;
  final String status;
  final TaskListModel id;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskListModel.title!, style: textTheme.titleMedium),
            SizedBox(height: 4),
            Text(
              widget.taskListModel.description!,
              style: textTheme.bodyMedium,
            ),
            Text(
              'Date :${widget.taskListModel.createdDate!}',
              style: TextStyle(color: Colors.blueAccent),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                    child: Text(widget.status),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.black, width: 2),
                          padding: EdgeInsets.all(0),
                          minimumSize: Size(35, 35),
                          elevation: 3,
                          backgroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {},
                        child: Icon(
                          Icons.edit_calendar_sharp,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ),
                      OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          side: BorderSide(color: Colors.black, width: 2),
                          minimumSize:Size(35, 35),
                          elevation: 5,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Delete'),
                                content: Text('Do you want to delete '),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteTask();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteTask() async {
    Loading = true;
    setState(() {});
    NetworkResponse response = await Networkcaller.getReqest(
      URLs.DeleteTaskURL('${widget.id.sId}'),
    );
    Loading = false;
    setState(() {});
    if (response.isSuccess) {
      message(context, 'delete complete');
    } else {
      message(context, 'delete fail !');
    }
  }
}
