import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title, message, yes, no;
  final Function pressYes, pressNo;
  final Color color = Colors.white12;
  const CustomConfirmationDialog(
      {this.title,
      this.message,
      this.yes,
      this.no,
      this.pressNo,
      this.pressYes});

  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(title),
      content: new Text(message),
      backgroundColor: color,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      contentTextStyle: TextStyle(color: Colors.white, fontSize: 12),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: [
        new TextButton(
            onPressed: pressNo,
            child: new Text(no,
                style: TextStyle(
                  fontSize: 14,
                ))),
        new TextButton(
            onPressed: pressYes,
            child: new Text(
              yes,
              style: TextStyle(fontSize: 12),
            ))
      ],
    );
  }
}
