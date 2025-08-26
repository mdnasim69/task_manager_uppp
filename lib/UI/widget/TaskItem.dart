import 'package:flutter/material.dart';
import 'package:task_manager/data/model/TaskListModel.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.color, required this.taskListModel});

  final Color color;
  final TaskListModel taskListModel;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskListModel.title!, style: textTheme.titleMedium),
            Text(taskListModel.description!, style: textTheme.bodyMedium),
             Text(
              'Date :${taskListModel.createdDate!}',
              style: TextStyle(color: Colors.blueAccent),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                    child: Text('New'),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete, color: Colors.red),
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
}
