import 'package:afs_task/core/constants/string_constants.dart';
import 'package:afs_task/models/response.dart';
import 'package:afs_task/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static late final Box _tasksBox;

  static init() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(TaskAdapter());
      _tasksBox = await Hive.openBox('tasks');
      return Response(message: "", isOperationSuccessful: true);
    } catch (e) {
      return Response(message: e.toString(), isOperationSuccessful: false);
    }
  }

  static Response getTasks() {
    try {
      // await _addTestData();
      return Response(
          message: "",
          isOperationSuccessful: true,
          data: _tasksBox.values.map((e) => e as Task).toList());
    } catch (e) {
      return Response(message: e.toString(), isOperationSuccessful: false);
    }
  }

  static Future<Response> addTask(Task task) async {
    try {
      await _tasksBox.add(task);
      return Response(
        message: StringConstants.taskAddedSuccufully,
        isOperationSuccessful: true,
      );
    } catch (e) {
      return Response(message: e.toString(), isOperationSuccessful: false);
    }
  }

  static Future<Response> updateTask(Task task) async {
    try {
      await task.save();
      return Response(
        message: StringConstants.taskEditedSuccufully,
        isOperationSuccessful: true,
      );
    } catch (e) {
      return Response(message: e.toString(), isOperationSuccessful: false);
    }
  }

  static Future<Response> deleteTask(Task task) async {
    try {
      await task.delete();
      return Response(
        message: StringConstants.taskDeletedSuccufully,
        isOperationSuccessful: true,
      );
    } catch (e) {
      return Response(message: e.toString(), isOperationSuccessful: false);
    }
  }
}
