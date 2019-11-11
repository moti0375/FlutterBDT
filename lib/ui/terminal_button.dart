import 'package:flutter/material.dart';

class TerminalButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;

  TerminalButton({this.onPressed, this.icon});

  @override
  _TerminalButtonState createState() => _TerminalButtonState();
}

class _TerminalButtonState extends State<TerminalButton> {
  bool isPressed = false;
  Color releaseColor = Color(0xff434343);
  Color pressedColor = Color(0xff636363);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.0),
            color: releaseColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0)),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(10.0),
          child: Center(
            child: Icon(
              widget.icon,
              color: Colors.red,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }

  void pressed() {
    widget.onPressed();
  }
}
