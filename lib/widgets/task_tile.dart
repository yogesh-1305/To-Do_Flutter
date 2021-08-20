import 'package:flutter/material.dart';

class SingleTaskTile extends StatelessWidget {
  SingleTaskTile(
      {required this.name,
      required this.isChecked,
      required this.checkBoxCallback});

  final String name;
  final bool isChecked;
  final Function checkBoxCallback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.task_alt),
      title: Text(name),
      trailing: Checkbox(
        activeColor: Colors.blue,
        value: isChecked,
        onChanged: (bool? value) {
          checkBoxCallback(value);
        },
      ),
    );
  }
}
