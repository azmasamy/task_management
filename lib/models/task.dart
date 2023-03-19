import 'package:hive_flutter/adapters.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isUrgent;

  Task(
      {required this.title, required this.description, required this.isUrgent});
}
