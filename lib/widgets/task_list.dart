import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return SingleTaskTile(
            name: taskData.tasks[index].name,
            isChecked: taskData.tasks[index].isDone,
            checkBoxCallback: (checkboxState) {
              taskData.updateTask(taskData.tasks[index]);
            },
          );
        },
        itemCount: taskData.taskCount,
      );
    });
  }
}
