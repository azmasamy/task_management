import 'package:ads_task/core/constants/string_constants.dart';
import 'package:ads_task/data/local_storage.dart';
import 'package:ads_task/models/response.dart';
import 'package:ads_task/models/task.dart';
import 'package:ads_task/modules/tasks/providers/tasks_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: constant_identifier_names
enum TasksBottomsheetState {
  INITIALIZING,
  INITIALIZED,
  LOADING,
  FAILED,
  SUCCEEDED
}

class TasksBottomsheetProvider extends ChangeNotifier {
  //make singleton
  TasksBottomsheetProvider._privateConstructor();
  static final TasksBottomsheetProvider _instance =
      TasksBottomsheetProvider._privateConstructor();
  factory TasksBottomsheetProvider() {
    return _instance;
  }

  TasksBottomsheetState state = TasksBottomsheetState.INITIALIZING;

  late TasksBottomsheetProvider tasksBottomsheetProvider;
  late TasksListProvider tasksListProvider;
  var taskTitleController = TextEditingController();
  var taskDescriptionController = TextEditingController();
  var taskFormKey = GlobalKey<FormState>();
  var isUrgentTask = false;
  late Response latestResponse;
  bool isBottomSheetOpened = false;

  init(Task? task, BuildContext context) {
    tasksListProvider = Provider.of<TasksListProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => updateState(TasksBottomsheetState.INITIALIZED));
    setStateData(task);
  }

  setTask(Task? task) async {
    if (taskFormKey.currentState!.validate()) {
      updateState(TasksBottomsheetState.LOADING);
      if (task == null) {
        // Add New Task
        latestResponse = await LocalStorage.addTask(Task(
            title: taskTitleController.text,
            description: taskDescriptionController.text,
            isCritical: isUrgentTask));
      } else {
        // Update Task
        task.title = taskTitleController.text;
        task.description = taskDescriptionController.text;
        task.isCritical = isUrgentTask;
        latestResponse = await LocalStorage.updateTask(task);
      }
      if (latestResponse.isOperationSuccessful) {
        tasksListProvider.updateState(TasksListState.RELOADING);
        updateState(TasksBottomsheetState.SUCCEEDED);
      } else {
        updateState(TasksBottomsheetState.FAILED);
      }
    }
  }

  editTask(Task task) async {
    updateState(TasksBottomsheetState.LOADING);
    latestResponse = await LocalStorage.updateTask(task);
    if (latestResponse.isOperationSuccessful) {
      updateState(TasksBottomsheetState.SUCCEEDED);
      tasksListProvider.updateState(TasksListState.SUCCEEDED);
    } else {
      updateState(TasksBottomsheetState.FAILED);
    }
  }

  updateState(TasksBottomsheetState state) {
    this.state = state;
    notifyListeners();
  }

  validateTaskTitle() {
    if (taskTitleController.text.isEmpty) {
      return StringConstants.taskTitleFieldError;
    }
    return null;
  }

  validateTaskDescription() {
    if (taskDescriptionController.text.isEmpty) {
      return StringConstants.taskDescriptionFieldError;
    }
    return null;
  }

  toggleBottomSheet() {
    isBottomSheetOpened = !isBottomSheetOpened;
    notifyListeners();
  }

  setUrgentTask(bool? value) {
    if (value != null) {
      isUrgentTask = value;
      notifyListeners();
    }
  }

  setStateData(Task? task) {
    if (task != null) {
      taskTitleController.text = task.title;
      taskDescriptionController.text = task.description;
      isUrgentTask = task.isCritical;
    }
  }

  _clearStateData() {
    taskTitleController.text = '';
    taskDescriptionController.text = '';
    isUrgentTask = false;
    latestResponse.message = '';
  }

  reinitialzeState(BuildContext context) {
    if (latestResponse.message.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(latestResponse.message),
        ));
        _clearStateData();
        updateState(TasksBottomsheetState.INITIALIZED);
      });
    }
  }
}
