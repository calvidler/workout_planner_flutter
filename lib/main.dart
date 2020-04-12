import 'package:flutter/material.dart';
import 'package:workout_planner_flutter/screens/tasks_screens.dart';
import 'package:provider/provider.dart';
import 'package:workout_planner_flutter/models/task_data.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
