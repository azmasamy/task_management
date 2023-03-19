import 'package:afs_task/core/style/style_constants/color_constants.dart';
import 'package:afs_task/data/local_storage.dart';
import 'package:afs_task/models/response.dart';
import 'package:afs_task/models/task.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum TasksListState { LOADING, RELOADING, LOADED }

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

  initialize() async {
    latestResponse = await LocalStorage.init();
    if (latestResponse.isOperationSuccessful) {
      getTasks();
    } else {
      updateState(TasksListState.LOADED);
    }
  }

  deleteTask(Task task) async {
    latestResponse = await LocalStorage.deleteTask(task);
    if (latestResponse.isOperationSuccessful) {
      updateState(TasksListState.RELOADING);
    } else {
      updateState(TasksListState.LOADED);
    }
  }

  updateState(TasksListState state) {
    this.state = state;
    notifyListeners();
  }

  reinitialzeState(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (latestResponse.message.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: ColorConstants.kPrimaryColor,
          content: Text(latestResponse.message),
        ));
        latestResponse.message = '';
      }
      getTasks();
    });
  }

  getTasks() {
    latestResponse = LocalStorage.getTasks();
    if (latestResponse.isOperationSuccessful) {
      tasks = latestResponse.data;
      updateState(TasksListState.LOADED);
    } else {
      updateState(TasksListState.LOADED);
    }
  }
}
