import 'package:bankingapplication/constants.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/banking_application/lib/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/rectangular_button.dart';
import 'package:pattern_formatter/date_formatter.dart';
import 'package:age/age.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bankingapplication/components/alert_message.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String name;
  String dob;
  String phone;
  String userAge;
  String lastLoginTime;
  String prompt = '';
  bool showSpinner = false;

  String getAge() {
    List ls = dob.split('/');
    int yr = int.parse(ls[2]);
    int month = int.parse(ls[1]);
    int date = int.parse(ls[0]);
    DateTime birthday = DateTime(yr, month, date);
    DateTime today = DateTime.now(); //2020/1/24
    lastLoginTime = today.toString();

    AgeDuration age;
    age = Age.dateDifference(
        fromDate: birthday, toDate: today, includeToDate: false);
    userAge = age.toString();
    return userAge;
  }

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
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter name'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  phone = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter mobile number'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  dob = value;
                  setState(() {
                    prompt = getAge();
                  });
                },
                inputFormatters: [
                  DateInputFormatter(),
                ],
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter date of birth(DD/MM/YYYY)'),
              ),
              SizedBox(
                height: 8.0,
              ),
              Center(
                child: Text(
                  prompt,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
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
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RectangularButton(
                colour: Color(0xFF2F2A89),
                buttonTitle: 'Register',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    if (!EmailValidator.validate(email)) {
                      throw Exception('Email invalid');
                    }
                    if (name != null && userAge != null && phone != null) {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: '$phone@email.com', password: password);
                      if (newUser != null) {
                        Firestore.instance
                            .collection('users')
                            .document(newUser.user.uid)
                            .setData({
                          'acc/no': newUser.user.uid,
                          'username': name,
                          'email': email,
                          'age': userAge,
                          'phone': phone,
                          'balance': 1000.0,
                          'last login time': lastLoginTime,
                        });
                        Navigator.pushNamed(context, HomeScreen.id);
                      }
                    } else {
                      throw Exception('Enter valid inputs');
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
                  } on Exception catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    createAlert(context: context, msg: e.toString());
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
