import 'package:ads_task/models/task.dart';
import 'package:ads_task/modules/tasks/ui/widgets/task_card.dart';
import 'package:flutter/material.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;
  const TasksList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) => TaskCard(task: tasks[index])),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
