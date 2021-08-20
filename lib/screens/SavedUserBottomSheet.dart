import 'package:flutter/material.dart';
import 'package:todo/firebase/FirebaseHandler.dart';

class SavedUserBottomSheet extends StatefulWidget {
  SavedUserBottomSheet({@required this.email, @required this.password});

  final String? email;
  final String? password;

  @override
  _SavedUserBottomSheetState createState() => _SavedUserBottomSheetState();
}

class _SavedUserBottomSheetState extends State<SavedUserBottomSheet> {
  Color progressBarColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Previous logged in accounts...'),
            ListTile(
              onTap: () {
                setState(() {
                  progressBarColor = Colors.blue;
                });
                FirebaseHandler.getInstance().signUpWithEmailAndPassword(
                    context, widget.email!, widget.password!);
              },
              leading: Icon(Icons.person),
              title: Text(
                '${widget.email}',
                style: TextStyle(fontSize: 16),
              ),
              trailing: CircularProgressIndicator(
                color: progressBarColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
