import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  final String topRowText;
  final String bottomRowText;

  DisplayWidget({this.bottomRowText = bottomRowDefaultText, this.topRowText = topRowDefaultText});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff535526),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        margin: EdgeInsets.all(18),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              topRowText,
              style: TextStyle(fontSize: 35),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              bottomRowText,
              style: TextStyle(fontSize: 35),
            ),
          ],
        ),
      ),
    );
  }

  static const topRowDefaultText = "Trim Low T = 000";
  static const bottomRowDefaultText = "RPM 0000 Pw 000";
}
