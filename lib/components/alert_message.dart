import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

void createAlert(
    {BuildContext context,
    String title = 'Error',
    String msg,
    AlertType alert = AlertType.error}) {
  Alert(
    context: context,
    type: alert,
    title: title,
    desc: msg,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
