import 'package:bankingapplication/screens/home_screen.dart';
import 'package:bankingapplication/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bankingapplication/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _auth = FirebaseAuth.instance;
final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

Drawer customDrawer(
    {BuildContext context,
    Function myAccountOnTap,
    Function checkBalanceOnTap,
    Function transferMoneyOnTap,
    Function historyOnTap}) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xFF2F2A89),
          ),
          child: Text(
            'Operations',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.account_circle,
            color: Color(0xFF2F2A89),
          ),
          title: Text('My Account'),
          onTap: myAccountOnTap,
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            color: Color(0xFF2F2A89),
          ),
          title: Text('Home'),
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName(HomeScreen.id));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.account_balance_wallet,
            color: Color(0xFF2F2A89),
          ),
          title: Text('Check Balance'),
          onTap: checkBalanceOnTap,
        ),
        ListTile(
          leading: Icon(
            Icons.transfer_within_a_station,
            color: Color(0xFF2F2A89),
          ),
          title: Text('Transfer Money'),
          onTap: transferMoneyOnTap,
        ),
        ListTile(
          leading: Icon(
            Icons.history,
            color: Color(0xFF2F2A89),
          ),
          title: Text('Transactions history'),
          onTap: historyOnTap,
        ),
        ListTile(
          leading: Icon(
            Icons.arrow_back,
            color: Color(0xFF2F2A89),
          ),
          title: Text('Back'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Color(0xFF2F2A89),
          ),
          title: Text('Log Out'),
          onTap: () async {
            try {
              final user = await _auth.currentUser();
              if (user != null) {
                loggedInUser = user;
              }
            } catch (e) {
              print(e);
            }
            _firestore
                .collection("users")
                .document(loggedInUser.uid)
                .updateData({'last login time': LoginScreen.lastLoginTime});
            _auth.signOut();
            Navigator.popUntil(context, ModalRoute.withName(WelcomeScreen.id));
          },
        ),
      ],
    ),
  );
}
