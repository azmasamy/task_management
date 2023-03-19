import 'package:afs_task/models/task.dart';
import 'package:afs_task/modules/tasks/providers/tasks_bottomsheet_provider.dart';
import 'package:afs_task/modules/tasks/ui/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;
  const TasksList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    TasksBottomsheetProvider tasksBottomsheetProvider =
        Provider.of<TasksBottomsheetProvider>(context);

    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) => TaskCard(task: tasks[index])),
        SizedBox(
          height: tasksBottomsheetProvider.isBottomSheetOpened ? 450 : 100,
        ),
      ],
    );
  }
}
