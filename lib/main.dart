import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/home_screen.dart';
import 'screens/account_info.dart';
import 'screens/transfer_money.dart';
import 'screens/check_balance.dart';
import 'screens/txn_history.dart';

void main() => runApp(BankingApp());

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AccountInfo.id: (context) => AccountInfo(),
        TransferMoney.id: (context) => TransferMoney(),
        CheckBalance.id: (context) => CheckBalance(),
        TxnHistory.id: (context) => TxnHistory(),
      },
    );
  }
}
