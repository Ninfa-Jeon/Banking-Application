import 'package:bankingapplication/constants.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/banking_application/lib/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/rectangular_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:bankingapplication/components/alert_message.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  static String lastLoginTime = DateTime.now().toString();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String phone;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdefaultBGColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  phone = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your phone'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RectangularButton(
                colour: Color(0xFF6092F7),
                buttonTitle: 'Log In',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.signInWithEmailAndPassword(
                        email: '$phone@email.com', password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } on AuthException catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    createAlert(context: context, msg: e.message);
                  } on PlatformException catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    createAlert(context: context, msg: e.message);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
