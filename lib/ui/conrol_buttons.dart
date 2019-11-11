import 'package:bluetooth_data_terminal/ui/terminal_button.dart';
import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final IconData upIcon;
  final IconData downIcon;

  ControlButtons(
      {this.onIncrement,
      this.onDecrement,
      this.upIcon = Icons.add,
      this.downIcon = Icons.remove});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          height: 40,
          width: 60,
          child: TerminalButton(
            icon: downIcon,
            onPressed: onDecrement,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          height: 40,
          width: 60,
          child: TerminalButton(
            icon: upIcon,
            onPressed: onIncrement,
          ),
        ),
      ],
    );
  }
}
