import 'package:bankingapplication/constants.dart';
import 'package:bankingapplication/screens/check_balance.dart';
import 'package:bankingapplication/screens/txn_history.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/banking_application/lib/components/custom_drawer.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/banking_application/lib/screens/account_info.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/banking_application/lib/screens/transfer_money.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdefaultBGColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF2F2A89),
        centerTitle: true,
        title: Text('Home'),
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
            Navigator.popAndPushNamed(context, TxnHistory.id);
          }),
      body: Center(
        child: RotateAnimatedTextKit(
          repeatForever: true,
          onTap: () {
            //
          },
          text: ["WELCOME!!!", "HAPPY", "BANKING"],
          textStyle: TextStyle(
              fontSize: 50.0,
              fontFamily: "PermanentMarker",
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
          alignment: Alignment.centerRight, // or Alignment.topLeft
        ),
      ),
    );
  }
}
