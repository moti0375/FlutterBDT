import 'dart:async';

import 'package:bluetooth/bluetooth.dart';
import 'package:bluetooth_data_terminal/bluetooth/ConnectionBase.dart';

class TerminalPageBloc{
  final ConnectionBase _connectionBase;
  TerminalPageBloc(this._connectionBase);
  StreamSubscription<ScanResult> listen;
  final  String deviceName = "LE-KC Butterball" ;

  void startDeviceScan(){
    listen = _connectionBase.scanForDevices().
    listen((result){
      print("ScanResult: ${result.device.id} : ${result.device.name}" );
      if(deviceName.toLowerCase() == result.device.name.toLowerCase()){
        print("Found: device: $deviceName");
        connectDevice(result.device);
        cancelScan();
      }
    });
  }

  void cancelScan(){
    listen.cancel();
  }

  void connectDevice(BluetoothDevice device) async {
    _connectionBase.connectDevice(device).listen((connectionState){
      print("connectDevice: $connectionState");
    });
  }
}