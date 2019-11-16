import 'dart:async';

import 'package:bluetooth_data_terminal/bluetooth/ConnectionBase.dart';
import 'package:bluetooth_data_terminal/model/bt_connection_state.dart';
import 'package:flutter_blue/flutter_blue.dart';

class TerminalPageBloc{
  final BluetoothConnectionBase _connectionBase;
  final  String deviceName = "Xicoy V10" ;
  Stream<TerminalDataModel> connectionStream;
  TerminalPageBloc(this._connectionBase){
    connectionStream = _connectionBase.getConnectionStream();
  }

  void startDeviceScan(){
    print("startDeviceScan: ");
    _connectionBase.scanAndConnect(deviceName);
  }

  void cancelScan(){
    print("Cancel Scan");
  }

  void dispose(){
    print("Bloc dispose");
    _connectionBase.dispose();
  }

}