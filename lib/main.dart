import 'package:bluetooth_data_terminal/bluetooth/ConnectionBase.dart';
import 'package:bluetooth_data_terminal/bluetooth/flutter_serial_service.dart';
import 'package:bluetooth_data_terminal/pages/terminal_page/terminal_page.dart';
import 'package:bluetooth_data_terminal/pages/terminal_page/terminal_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider<TerminalPageBloc>(
        builder: (context) => TerminalPageBloc(FlutterSerialService()),
        child: Consumer<TerminalPageBloc>(
          builder: (context, bloc, _) => TerminalPage(bloc: bloc),
        ),
        dispose: (context, bloc) {
          print("Dispose..");
          bloc.dispose();
        },
      ),
    );
  }
}