import 'package:bluetooth_data_terminal/ui/conrol_buttons.dart';
import 'package:bluetooth_data_terminal/ui/display.dart';
import 'package:bluetooth_data_terminal/ui/terminal_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TerminalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Bluetooth Data Terminal",
          style: TextStyle(
            fontSize: 20,
            color: Colors.yellow,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100, top: 40),
              child: DisplayWidget(),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ControlButtons(
                  onIncrement: onRpmUp,
                  onDecrement: onRpmDown,
                  downIcon: Icons.keyboard_arrow_down,
                  upIcon: Icons.keyboard_arrow_up,
                ),
                SizedBox(width: 40,),
                ControlButtons(
                  onIncrement: onUp,
                  onDecrement: onDown,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onRpmUp() {
  }

  void onRpmDown() {
  }

  void onUp() {
  }

  void onDown() {
  }
}
