import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(String taskName) {
    tasks.add(Task(name: taskName));
    notifyListeners();
  }

  int get taskCount {
    return tasks.length;
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }
}
