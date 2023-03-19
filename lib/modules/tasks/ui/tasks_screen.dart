import 'package:ads_task/core/constants/string_constants.dart';
import 'package:ads_task/core/style/style_constants/color_constants.dart';
import 'package:ads_task/modules/tasks/providers/tasks_list_provider.dart';
import 'package:ads_task/modules/tasks/ui/widgets/task_bottom_sheet.dart';
import 'package:ads_task/modules/tasks/ui/widgets/tasks_floating_action_button.dart';
import 'package:ads_task/modules/tasks/ui/widgets/tasks_list.dart';
import 'package:ads_task/modules/tasks/ui/widgets/tasks_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: const TasksBottomsheet(),
        floatingActionButton: const TasksFloatingActionButton(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              buildUserInfo(),
              Consumer<TasksListProvider>(
                builder: (context, tasksListProvider, child) =>
                    buildScreenBody(tasksListProvider),
              ),
            ]),
          ),
        ));
  }

  buildUserInfo() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                StringConstants.welcomeTitle,
                style: TextStyle(
                    color: ColorConstants.kPrimaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                StringConstants.greatDay,
                style: TextStyle(
                    color: ColorConstants.kPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }

  buildScreenBody(TasksListProvider tasksListProvider) {
    switch (tasksListProvider.state) {
      case TasksListState.LOADING:
        tasksListProvider.initialize();
        return buildLoadingScreen();
      case TasksListState.FAILED:
        tasksListProvider.displayErrorMessage(context);
        return buildTasks(tasksListProvider);
      case TasksListState.SUCCEEDED:
        return buildTasks(tasksListProvider);
      case TasksListState.RELOADING:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          tasksListProvider.getTasks();
        });
        return buildLoadingScreen();
    }
  }

  buildTasks(TasksListProvider tasksListProvider) {
    return Column(
      children: [
        TasksScreenHeader(tasksCount: tasksListProvider.tasks.length),
        TasksList(tasks: tasksListProvider.tasks)
      ],
    );
  }

  buildLoadingScreen() {
    return const SizedBox(
      height: 120,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
