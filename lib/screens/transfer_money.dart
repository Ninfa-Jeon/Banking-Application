import 'package:bankingapplication/screens/check_balance.dart';
import 'package:bankingapplication/screens/txn_history.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import '../components/rectangular_button.dart';
import '../components/custom_drawer.dart';
import 'account_info.dart';
import 'package:bankingapplication/components/alert_message.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
final _auth = FirebaseAuth.instance;
var accNo;
var holderName;
num transferAmount;
double senderBalance;
double recipientBalance;
bool showSpinner = false;

void checkValidity() async {
  try {
    final user = await _auth.currentUser();
    if (user != null) {
      loggedInUser = user;
    }
  } catch (e) {
    print(e);
  }
}

class TransferMoney extends StatefulWidget {
  static const String id = 'transfer_money';
  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  @override
  void initState() {
    checkValidity();
    super.initState();
  }

  void historyUpdate() {
    try {
      Firestore.instance.collection('txn_history').document().setData({
        'txn_id': FieldPath.documentId.hashCode,
        'date': DateTime.now().toString(),
        'sender': loggedInUser.uid,
        'recipient': accNo,
        'amount': transferAmount,
      });
    } on Exception catch (e) {
      createAlert(context: context, msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdefaultBGColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF2F2A89),
        centerTitle: true,
        title: Text('Money Transfer'),
      ),
      drawer: customDrawer(
        context: context,
        myAccountOnTap: () {
          Navigator.popAndPushNamed(context, AccountInfo.id);
        },
        transferMoneyOnTap: () {
          Navigator.pop(context);
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
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: controller1,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  accNo = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter account number of recipient'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: controller2,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  holderName = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter name of the recipient'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: controller3,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  transferAmount = double.parse(value);
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter amount to transfer'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RectangularButton(
                colour: Color(0xFF2F2A89),
                buttonTitle: 'Transfer',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    await for (var snapshot
                        in _firestore.collection('users').snapshots()) {
                      var sender = snapshot.documents
                          .firstWhere((element) =>
                              element.data['acc/no'] == loggedInUser.uid)
                          .data;
                      senderBalance = sender['balance'];
                      var recipient = snapshot.documents.firstWhere(
                          (element) => element.data['acc/no'] == accNo,
                          orElse: () {
                        throw Exception('Invalid Account Number');
                      }).data;
                      if (transferAmount > senderBalance) {
                        throw Exception('Insufficient amount');
                      }
                      if (recipient['username'] != holderName) {
                        throw Exception('Invalid recipient name');
                      }
                      recipientBalance = recipient['balance'];
                      if (senderBalance != null && recipientBalance != null) {
                        break;
                      }
                    }
                    var receive = recipientBalance + transferAmount;
                    var send = senderBalance - transferAmount;
                    _firestore
                        .collection("users")
                        .document(accNo)
                        .updateData({'balance': receive});
                    _firestore
                        .collection("users")
                        .document(loggedInUser.uid)
                        .updateData({'balance': send});
                    historyUpdate();
                    createAlert(
                      context: context,
                      title: 'Transaction successful',
                      msg: '$transferAmount sent',
                      alert: AlertType.success,
                    );
                    setState(
                      () {
                        showSpinner = false;
                        controller3.clear();
                        controller2.clear();
                        controller1.clear();
                      },
                    );
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
