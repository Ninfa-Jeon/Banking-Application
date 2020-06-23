import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  RectangularButton(
      {@required this.colour,
      @required this.buttonTitle,
      @required this.onPressed});

  final Color colour;
  final String buttonTitle;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonTitle,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
