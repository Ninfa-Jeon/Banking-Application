import 'file:///C:/Users/HP/AndroidStudioProjects/banking_application/lib/screens/login_screen.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/banking_application/lib/screens/registration_screen.dart';
import 'package:bankingapplication/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/rectangular_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdefaultBGColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: ColorizeAnimatedTextKit(
                speed: Duration(seconds: 5),
                text: ['PayNet Bank'],
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontSize: 50.0,
                  fontFamily: 'PermanentMarker',
                ),
                colors: [
                  Colors.deepPurple,
                  Colors.deepPurpleAccent,
                  Colors.blueGrey,
                  Colors.blueAccent,
                  Colors.blue,
                  Colors.lightBlue,
                  Colors.lightBlueAccent,
                ],
              ),
            ),
            RectangularButton(
              colour: Color(0xFF6092F7),
              buttonTitle: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RectangularButton(
              colour: Color(0xFF2F2A89),
              buttonTitle: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
