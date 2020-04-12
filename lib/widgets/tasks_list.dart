import 'package:flutter/material.dart';
import 'package:workout_planner_flutter/widgets/task_tile.dart';
import 'package:workout_planner_flutter/models/task.dart';
import 'package:provider/provider.dart';
import 'package:workout_planner_flutter/models/task_data.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "DELETE",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  taskData.deleteTask(task);
                });
              },
              child: TaskTile(
                taskTitle: task.name,
                isChecked: task.isDone,
                checkboxCallback: (checkboxState) {
                  taskData.toggleDone(task);
                },
              ),
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
