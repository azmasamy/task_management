import 'package:ads_task/core/style/style_constants/color_constants.dart';
import 'package:ads_task/models/task.dart';
import 'package:ads_task/modules/tasks/ui/widgets/task_card_popup_menu.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.visible,
                        task.title,
                        style: const TextStyle(
                            color: ColorConstants.kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  task.description,
                  style: const TextStyle(
                    color: ColorConstants.kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        task.isUrgent
            ? Container(
                width: 20,
                height: 20,
                padding: const EdgeInsets.all(6),
                decoration: const ShapeDecoration(
                  color: ColorConstants.kErrorColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              )
            : Container(),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: TaskCardPopupMenu(task: task))),
      ],
    );
  }
}
