import 'package:afs_task/core/constants/string_constants.dart';
import 'package:afs_task/core/style/style_constants/color_constants.dart';
import 'package:flutter/material.dart';

class TasksScreenHeader extends StatelessWidget {
  final int tasksCount;
  const TasksScreenHeader({super.key, required this.tasksCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            StringConstants.yourTasksTitle,
            style: TextStyle(
                color: ColorConstants.kPrimaryColor,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "$tasksCount ${StringConstants.tasksLabel}",
            style: const TextStyle(
              color: ColorConstants.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
