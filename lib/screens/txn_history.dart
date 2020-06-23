import 'package:bankingapplication/screens/check_balance.dart';
import 'package:flutter/material.dart';
import 'package:bankingapplication/constants.dart';
import 'package:bankingapplication/components/custom_drawer.dart';
import 'account_info.dart';
import 'transfer_money.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bankingapplication/components/custom_card.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
final _auth = FirebaseAuth.instance;

class TxnHistory extends StatefulWidget {
  static const String id = 'txn_history';
  @override
  _TxnHistoryState createState() => _TxnHistoryState();
}

class _TxnHistoryState extends State<TxnHistory> {
  List<Widget> txnList = [];

  void txnWidgets() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
    await for (var snapshot in _firestore
        .collection('txn_history')
        .orderBy('date', descending: false)
        .snapshots()) {
      Iterable users = snapshot.documents.where((element) =>
          element.data['sender'] == loggedInUser.uid ||
          element.data['recipient'] == loggedInUser.uid);
      for (var user in users) {
        var txnId = user['txn_id'];
        var date = user['date'];
        var amount = user['amount'];
        var status = user['sender'] == loggedInUser.uid ? 'Sent' : 'Received';
        var prompt = status == 'Sent' ? 'Sent to ' : 'Received from ';
        var otherAcc = user['sender'] == loggedInUser.uid
            ? user['recipient']
            : user['sender'];
        setState(() {
          txnList.add(
            CustomCard(
              fields: ['Txn id', 'Date', 'Amount', 'Status', '$prompt'],
              values: ['$txnId', '$date', 'Rs.$amount', '$status', '$otherAcc'],
            ),
          );
        });
      }
    }
  }

  @override
  void initState() {
    txnWidgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdefaultBGColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF2F2A89),
        centerTitle: true,
        title: Text('Transactions History'),
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
          Navigator.popAndPushNamed(context, CheckBalance.id);
        },
        historyOnTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: txnList,
        ),
      ),
    );
  }
}
