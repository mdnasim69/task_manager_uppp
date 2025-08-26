import 'TaskListModel.dart';

class TaskListByStatusModel {
  String? status;
  List<TaskListModel>? data;

  TaskListByStatusModel({this.status, this.data});

  TaskListByStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TaskListModel>[];
      json['data'].forEach((v) {
        data!.add( TaskListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

