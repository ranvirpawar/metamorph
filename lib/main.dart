import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:metamorph/src/task_list_screen.dart';
import 'package:metamorph/theme/app_theme.dart';

import 'database/task_db_model.dart';
import 'database/task_type_db_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures async code runs before runApp
  // await Hive.initFlutter();
  // Hive.registerAdapter(TaskTypeDBModelAdapter());
  // Hive.registerAdapter(TaskDBModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkAppTheme,
      home: TaskListPage(),
    );
  }
}


