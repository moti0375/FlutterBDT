import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

abstract class ConnectionBase{
  Stream<ScanResult> scanForDevices();
  void cancelScan();
  Future<void> connectDevice(BluetoothDevice device);
  Future<void> disconnectDevice();
  Stream<String> deviceDataStream();
  Stream<BluetoothState> connectionStream();
}

class BluetoothManager implements ConnectionBase{
  FlutterBlue _flutterBlue = FlutterBlue.instance;

  @override
  Future<void> connectDevice(BluetoothDevice device) async {
    return await device.connect();
  }

  @override
  Stream<String> deviceDataStream() {
    // TODO: implement deviceDataStream
    return null;
  }

  @override
  Future<void> disconnectDevice() {
    return null;
  }

  @override
  Stream<ScanResult> scanForDevices() {
    return _flutterBlue.scan();
  }

  @override
  void cancelScan() {
    _flutterBlue.stopScan();
  }

  @override
  Stream<BluetoothState> connectionStream() {
    return _flutterBlue.state;
  }

}

