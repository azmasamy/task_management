import 'package:afs_task/core/constants/string_constants.dart';
import 'package:afs_task/core/reusable_widgets/app_text_form_field.dart';
import 'package:afs_task/core/style/style_constants/color_constants.dart';
import 'package:afs_task/modules/tasks/providers/tasks_bottomsheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksBottomsheet extends StatelessWidget {
  const TasksBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    TasksBottomsheetProvider tasksBottomsheetProvider =
        Provider.of<TasksBottomsheetProvider>(context);

    switch (tasksBottomsheetProvider.state) {
      case TasksBottomsheetState.INITIALIZING:
        tasksBottomsheetProvider.init(context);
        break;
      case TasksBottomsheetState.INITIALIZED:
        break;
      case TasksBottomsheetState.LOADING:
        break;
      case TasksBottomsheetState.FAILED:
        tasksBottomsheetProvider.reinitialzeState(context);
        break;
      case TasksBottomsheetState.SUCCEEDED:
        tasksBottomsheetProvider.reinitialzeState(context);
        break;
    }

    return tasksBottomsheetProvider.isBottomSheetOpened
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
                AppTextFormField(
                  label: StringConstants.taskTitleFieldLabel,
                  textEditingController:
                      tasksBottomsheetProvider.taskTitleController,
                  hintText: StringConstants.taskTitleFieldHint,
                  validator: (input) =>
                      tasksBottomsheetProvider.validateTaskTitle(),
                  autoFocus: true,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 15,
                ),
                AppTextFormField(
                  label: StringConstants.taskDescriptionFieldLabel,
                  textEditingController:
                      tasksBottomsheetProvider.taskDescriptionController,
                  hintText: StringConstants.taskDescriptionFieldHint,
                  validator: (input) =>
                      tasksBottomsheetProvider.validateTaskDescription(),
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      StringConstants.isUrgentTaskFieldLabel,
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
                  height: 10,
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
                        onPressed: () => tasksBottomsheetProvider.setTask(),
                        child: tasksBottomsheetProvider.state ==
                                TasksBottomsheetState.LOADING
                            ? const SizedBox(
                                width: 50,
                                child: CircularProgressIndicator(),
                              )
                            : Text(tasksBottomsheetProvider.editedTask == null
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
