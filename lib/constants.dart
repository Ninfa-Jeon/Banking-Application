import 'package:flutter/material.dart';

var kTextFieldDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(color: Color(0xFF2F2A89)),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF6092F7), width: 1.0),
    borderRadius: BorderRadius.circular(10.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF2F2A89), width: 2.0),
    borderRadius: BorderRadius.circular(10.0),
  ),
);

const kdefaultBGColor = Color(0xFFB1CCFC);
