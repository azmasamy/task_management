import 'package:ads_task/models/response.dart';
import 'package:ads_task/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static late final Box _tasksBox;

  static init() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(TaskAdapter());
      _tasksBox = await Hive.openBox('tasks');
      return Response(
          message: "Storage Initialization Successfully",
          isOperationSuccessful: true);
    } catch (e) {
      return Response(
          message: e.toString(),
          isOperationSuccessful: false);
    }
  }

  static Response getTasks() {
    try {
      // await _addTestData();
      return Response(
          message: "Tasks Fetched Successfully",
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
          message: "Tasks Added Successfully",
          isOperationSuccessful: true,
          data: _tasksBox.get('tasks'));
    } catch (e) {
      return Response(message: e.toString(), isOperationSuccessful: false);
    }
  }

  static Future<Response> updateTask(Task task) async {
    try {
      await task.save();
      return Response(
          message: "Tasks Updated Successfully",
          isOperationSuccessful: true,
          data: _tasksBox.get('tasks'));
    } catch (e) {
      return Response(message: e.toString(), isOperationSuccessful: false);
    }
  }

  static Future<Response> deleteTask(Task task) async {
    try {
      await _tasksBox.delete(task);
      return Response(
          message: "Tasks Deleted Successfully",
          isOperationSuccessful: true,
          data: _tasksBox.get('tasks'));
    } catch (e) {
      return Response(message: e.toString(), isOperationSuccessful: false);
    }
  }

  static _addTestData() async {
    await _tasksBox.add(
        Task(title: "title1", description: "description", isCritical: true));
    await _tasksBox.add(
        Task(title: "title2", description: "description", isCritical: false));
    await _tasksBox.add(
        Task(title: "title3", description: "description", isCritical: true));
  }
}
