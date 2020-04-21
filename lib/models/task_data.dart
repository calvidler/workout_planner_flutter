import 'package:flutter/material.dart';
import 'package:workout_planner_flutter/data/database_helper.dart';
import 'package:workout_planner_flutter/models/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;
  List<Task> _tasks = [
//    Task(name: 'Buy eggs', id: 200),
//    Task(name: 'Buy milk', id: 201),
//    Task(name: 'Buy paper', id: 202),
  ];
  TaskData() {
    _queryTasks();
    notifyListeners();
  }

  int get taskCount => _tasks.length;

  void addTask(String newTaskTitle) {
    final task = newTaskTitle;
    _insertTask(taskTitle: newTaskTitle);
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void toggleDone(Task task) {
    task.toggleDone();
    notifyListeners();
    _updateTask(task: task);
  }

  //SQFLITE queries

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
    _deleteTask(task);
  }

  void _queryTasks() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row['_id']));
    allRows.forEach((row) => _tasks.add(
        Task(name: row['task'], isChecked: row['isChecked'], id: row['_id'])));
    print("notify");
    notifyListeners();
  }

  void _insertTask({String taskTitle, int isChecked = 0}) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnTask: taskTitle,
      DatabaseHelper.columnIsChecked: isChecked,
    };
    final id = await dbHelper.insert(row);
    final task = Task(name: taskTitle, isChecked: isChecked, id: id);
    _tasks.add(task);

    print('inserted row id: $id');
  }

  void _updateTask({@required Task task}) async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: task.id,
      DatabaseHelper.columnIsChecked: task.isDone
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _deleteTask(Task task) async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(task.id);
    print('deleted $rowsDeleted row(s): row ${task.id}');
  }
}
