import 'package:afs_task/modules/tasks/providers/tasks_bottomsheet_provider.dart';
import 'package:afs_task/modules/tasks/providers/tasks_list_provider.dart';
import 'package:afs_task/modules/tasks/ui/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/string_constants.dart';
import 'core/style/theme.dart';

void main() {
  var app = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TasksListProvider()),
      ChangeNotifierProvider(create: (_) => TasksBottomsheetProvider()),
    ],
    child: const MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: StringConstants.appTitle,
        theme: appTheme(context),
        home: const TasksScreen());
  }
}
