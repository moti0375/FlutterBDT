import 'package:bluetooth_data_terminal/model/bt_connection_state.dart';
import 'package:bluetooth_data_terminal/pages/terminal_page/terminal_page_bloc.dart';
import 'package:bluetooth_data_terminal/ui/bluetooth_connection_indicator.dart';
import 'package:bluetooth_data_terminal/ui/conrol_buttons.dart';
import 'package:bluetooth_data_terminal/ui/display.dart';
import 'package:bluetooth_data_terminal/ui/terminal_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TerminalPage extends StatefulWidget {
  final TerminalPageBloc bloc;

  TerminalPage({this.bloc});

  @override
  State<StatefulWidget> createState() {
    return TerminalPageState();
  }
}

  class TerminalPageState extends State<TerminalPage> with WidgetsBindingObserver{
  @override
  void initState() {
    super.initState();
    print("initState");
    widget.bloc.startDeviceScan();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print("dispose:");
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TerminalDataModel>(
      stream: widget.bloc.connectionStream,
      initialData: TerminalDataModel(),
      builder: (context, snapshot) {
        print("build: ${snapshot.data}");
        return  Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Bluetooth Data Terminal",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.yellow,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: BluetoothConnectionIndicator(state: snapshot.data.connectionState,),
                  )
                ],
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
                    child: DisplayWidget(topRowText: snapshot.data.row1, bottomRowText: snapshot.data.row2,),
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
    );
  }

  void onRpmUp() {
    print("RpmUp pressed");
  }

  void onRpmDown() {
    print("RpmDown pressed");
  }

  void onUp() {
    print("up pressed");
  }

  void onDown() {
    print("down pressed");
  }
}
