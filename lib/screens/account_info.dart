import 'package:bankingapplication/screens/check_balance.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/custom_card.dart';
import '../components/custom_drawer.dart';
import 'transfer_money.dart';
import 'package:bankingapplication/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'txn_history.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
final _auth = FirebaseAuth.instance;
var username;
var phone;
var age;
var email;
var lastLoginTime;
var accNo;
bool showSpinner = false;

class AccountInfo extends StatefulWidget {
  static const String id = 'account_info';
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  void initState() {
    setNull();
    accountDetails();
    super.initState();
  }

  void accountDetails() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
    await for (var snapshot in _firestore.collection('users').snapshots()) {
      var user = snapshot.documents
          .firstWhere((element) => element.data['acc/no'] == loggedInUser.uid)
          .data;
      setState(() {
        accNo = user['acc/no'];
        username = user['username'];
        email = user['email'];
        lastLoginTime = user['last login time'];
        phone = user['phone'];
        age = user['age'];
        showSpinner = false;
      });
    }
  }

  void setNull() {
    setState(() {
      showSpinner = true;
      accNo = null;
      username = null;
      email = null;
      lastLoginTime = null;
      phone = null;
      age = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdefaultBGColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF2F2A89),
        centerTitle: true,
        title: Text('Account Info'),
      ),
      drawer: customDrawer(
        context: context,
        myAccountOnTap: () {
          Navigator.pop(context);
        },
        transferMoneyOnTap: () {
          Navigator.popAndPushNamed(context, TransferMoney.id);
        },
        checkBalanceOnTap: () {
          Navigator.popAndPushNamed(context, CheckBalance.id);
        },
        historyOnTap: () {
          Navigator.popAndPushNamed(context, TxnHistory.id);
        },
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              CustomCard(
                fields: ['Account no.'],
                values: [accNo],
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomCard(
                fields: ['Name'],
                values: [username],
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomCard(
                fields: ['Email'],
                values: [email],
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomCard(
                fields: ['Mobile Number'],
                values: [phone],
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomCard(
                fields: ['Age'],
                values: [age],
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomCard(
                fields: ['Last Login'],
                values: [lastLoginTime],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
