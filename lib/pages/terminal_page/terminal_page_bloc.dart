import 'dart:async';

import 'package:bluetooth_data_terminal/bluetooth/ConnectionBase.dart';
import 'package:flutter_blue/flutter_blue.dart';

class TerminalPageBloc{
  final ConnectionBase _connectionBase;
  StreamSubscription<ScanResult> listen;
  final  String deviceName = "LE_WH-1000XM3" ;
  TerminalPageBloc(this._connectionBase){
   //startDeviceScan();
  }

  void startDeviceScan(){
    print("startDeviceScan: ");
     listen = _connectionBase.scanForDevices().where((d){return d.device.name.isNotEmpty;}).distinct().listen((result){
      print("ScanResult: ${result.device.id} : ${result.device.name}" );
      if(deviceName.toLowerCase() == result.device.name.toLowerCase()){
        print("Found: device: $deviceName");
        connectDevice(result.device);
      }
    });
  }

  void resumeScan(){
    print("Resume BT scanning");
    if(listen == null){
      startDeviceScan();
    } else {
      if(listen.isPaused){

        listen.resume();
      }
    }
  }
  void cancelScan(){
    print("Cancel Scan");
    listen.cancel();
    listen = null;
  }

  void pauseScan(){
    print("Pause Scan");
    listen.pause();
  }

  void connectDevice(BluetoothDevice device) async {
    print("About to connect device: ${device.name}");
    await _connectionBase.connectDevice(device).then((_){
      print("connectDevice: ${device.state}");
      _startConnectionListener(device.state);
    }).catchError((e){
      print("There was an error: $e");
    });
  }

  void dispose(){
    print("Bloc dispose");
    cancelScan();
//    _connectionBase.cancelScan();
  }

  void _startConnectionListener(Stream<BluetoothDeviceState> state){
    state.listen((connectionState){
      print("ConnectionListener: ${connectionState.toString()}");
      if(connectionState == BluetoothDeviceState.connected){
        pauseScan();
      } else {
        resumeScan();
      }
    });
  }
}