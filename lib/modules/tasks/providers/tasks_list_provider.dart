import 'package:ads_task/data/local_storage.dart';
import 'package:ads_task/models/response.dart';
import 'package:ads_task/models/task.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum TasksListState { LOADING, FAILED, SUCCEEDED }

class TasksListProvider extends ChangeNotifier {
  //make singleton
  TasksListProvider._privateConstructor();
  static final TasksListProvider _instance =
      TasksListProvider._privateConstructor();
  factory TasksListProvider() {
    return _instance;
  }

  TasksListState state = TasksListState.LOADING;
  List<Task> tasks = [];
  late Response latestResponse;

  getTasks() async {
    latestResponse = await LocalStorage.getTasks();
    if (latestResponse.isOperationSuccessful) {
      tasks = latestResponse.data;
      updateState(TasksListState.SUCCEEDED);
    } else {
      updateState(TasksListState.FAILED);
    }
  }

  deleteTask(Task task) async {
    latestResponse = await LocalStorage.deleteTask(task);
    if (latestResponse.isOperationSuccessful) {
      updateState(TasksListState.SUCCEEDED);
      tasks = latestResponse.data;
    } else {
      updateState(TasksListState.FAILED);
    }
  }

  updateState(TasksListState state) {
    this.state = state;
    notifyListeners();
  }

  displayErrorMessage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(latestResponse.message),
      ));
    });
  }
}
