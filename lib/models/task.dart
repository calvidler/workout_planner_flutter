import 'package:flutter/cupertino.dart';

class Task {
  final String name;
  bool isDone;
  final int id;

  Task({this.name, int isChecked = 0, this.id}) {
    if (isChecked == 1)
      isDone = true;
    else
      isDone = false;
  }

  void toggleDone() => isDone = !isDone;
}
