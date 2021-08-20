import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';

class AddTaskBottomSheet extends StatefulWidget {
  static const id = 'add_task_screen';

  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var taskTitle = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text("Add a task"),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  onChanged: (value) {
                    taskTitle = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Task",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text('Add task'),
                  onPressed: () {
                    setState(() {
                      print(taskTitle);
                      Provider.of<TaskData>(context, listen: false)
                          .addTask(taskTitle);
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          )),
    );
  }
}
