import 'package:ads_task/core/constants/string_constants.dart';
import 'package:ads_task/core/style/style_constants/color_constants.dart';
import 'package:ads_task/models/task.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                      color: ColorConstants.kPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                task.isCritical
                    ? Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const ShapeDecoration(
                          color: ColorConstants.kErrorBackgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                        ),
                        child: const Text(StringConstants.urgentTaskLabel),
                      )
                    : Container()
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
    );
  }
}
