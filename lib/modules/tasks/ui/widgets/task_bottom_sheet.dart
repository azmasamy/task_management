import 'package:ads_task/core/constants/string_constants.dart';
import 'package:ads_task/core/reusable_widgets/ads_text_form_field.dart';
import 'package:ads_task/core/style/style_constants/color_constants.dart';
import 'package:ads_task/models/task.dart';
import 'package:ads_task/modules/tasks/providers/tasks_bottomsheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksBottomsheet extends StatelessWidget {
  final Task? task;
  const TasksBottomsheet({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    TasksBottomsheetProvider tasksBottomsheetProvider =
        Provider.of<TasksBottomsheetProvider>(context);

    if (tasksBottomsheetProvider.state == TasksBottomsheetState.INITIALIZING) {
      tasksBottomsheetProvider.init(task);
    }

    return tasksBottomsheetProvider.isBottomSheetOpended
        ? Container(
            padding: const EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: Form(
              key: tasksBottomsheetProvider.taskFormKey,
              child: ListView(shrinkWrap: true, children: [
                ADSTextFormField(
                  label: StringConstants.taskTitleFieldLabel,
                  textEditingController:
                      tasksBottomsheetProvider.taskTitleController,
                  hintText: StringConstants.taskTitleFieldHint,
                  validator: (input) =>
                      tasksBottomsheetProvider.validateTaskTitle(),
                  autoFocus: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                ADSTextFormField(
                    label: StringConstants.taskDescriptionFieldLabel,
                    textEditingController:
                        tasksBottomsheetProvider.taskDescriptionController,
                    hintText: StringConstants.taskDescriptionFieldHint,
                    validator: (input) =>
                        tasksBottomsheetProvider.validateTaskDescription(),
                    maxLines: 5),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      StringConstants.isUrgentTaskLabel,
                      style: TextStyle(
                          fontSize: 15,
                          color: ColorConstants.kPrimaryAccentColor),
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: ColorConstants.kPrimaryColor,
                      value: tasksBottomsheetProvider.isUrgentTask,
                      onChanged: (value) =>
                          tasksBottomsheetProvider.setUrgentTask(value),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: MaterialButton(
                        elevation: 0,
                        height: 50,
                        color: ColorConstants.kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: () => tasksBottomsheetProvider.setTask(task),
                        child: Text(task == null
                            ? StringConstants.addButtonLabel
                            : StringConstants.updateButtonLabel))),
              ]),
            ),
          )
        : const SizedBox(
            height: 0,
          );
  }
}
