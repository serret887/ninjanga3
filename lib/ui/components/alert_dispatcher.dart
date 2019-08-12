import 'package:flutter/material.dart';

class AlertDispather extends StatelessWidget {
  final Function dispatch;
  final String message;

  const AlertDispather(
      {this.dispatch,
      this.message = "Looks like the system is unavaliable, please try again"});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(message),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Try Again'),
          onPressed: () {
            Navigator.of(context).pop();
            dispatch();
          },
        )
      ],
    );
  }
}
