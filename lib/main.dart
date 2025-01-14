import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metamorph/src/task_list_screen.dart';
import 'package:metamorph/theme/app_theme.dart';

void main() {
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


