import 'package:bankingapplication/components/custom_drawer.dart';
import 'package:bankingapplication/screens/txn_history.dart';
import 'package:flutter/material.dart';
import 'package:bankingapplication/screens/account_info.dart';
import 'package:bankingapplication/screens/transfer_money.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bankingapplication/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
final _auth = FirebaseAuth.instance;
var balance;
bool showSpinner = false;

class CheckBalance extends StatefulWidget {
  static const String id = 'check_balance';
  @override
  _CheckBalanceState createState() => _CheckBalanceState();
}

class _CheckBalanceState extends State<CheckBalance> {
  @override
  void initState() {
    setNull();
    getBalance();
    super.initState();
  }

  void getBalance() async {
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
        balance = user['balance'];
        showSpinner = false;
      });
    }
  }

  void setNull() {
    setState(() {
      showSpinner = true;
      balance = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdefaultBGColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF2F2A89),
        centerTitle: true,
        title: Text('Check Balance'),
      ),
      drawer: customDrawer(
        context: context,
        myAccountOnTap: () {
          Navigator.popAndPushNamed(context, AccountInfo.id);
        },
        transferMoneyOnTap: () {
          Navigator.popAndPushNamed(context, TransferMoney.id);
        },
        checkBalanceOnTap: () {
          Navigator.pop(context);
        },
        historyOnTap: () {
          Navigator.popAndPushNamed(context, TxnHistory.id);
        },
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
            ),
            Text(
              'Balance in your account is: \n',
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              'Rs.$balance',
              style: TextStyle(fontSize: 50.0, fontFamily: 'AlfaSlabOne'),
            ),
          ],
        ),
      ),
    );
  }
}
