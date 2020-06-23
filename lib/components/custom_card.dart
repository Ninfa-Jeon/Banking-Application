import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.fields, @required this.values});

  final List fields;
  final List values;

  List<Widget> fieldValuePair() {
    List<Widget> pairs = [];
    for (int i = 0; i < fields.length; i++) {
      pairs.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              fields[i].toString() + ': ',
              style: TextStyle(fontSize: 20.0, fontFamily: 'AlfaSlabOne'),
            ),
            Text(
              values[i].toString(),
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      );
    }
    return pairs;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      color: Color(0xFFDDEAF1),
      shadowColor: Color(0xFF2F445F),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: fieldValuePair(),
          ),
        ),
      ),
    );
  }
}
