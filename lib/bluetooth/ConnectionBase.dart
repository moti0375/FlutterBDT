import 'dart:async';

import 'package:bluetooth/bluetooth.dart';

abstract class ConnectionBase{
  Stream<ScanResult> scanForDevices();
  void cancelScan();
  Stream<BluetoothDeviceState> connectDevice(BluetoothDevice device);
  Future<void> disconnectDevice();
  Stream<String> deviceDataStream();
}

class BluetoothManager implements ConnectionBase{

  FlutterBlue _flutterBlue = FlutterBlue.instance;

  @override
  Stream<BluetoothDeviceState> connectDevice(BluetoothDevice device) {
    return _flutterBlue.connect(device, timeout: Duration(milliseconds: 2000), autoConnect: false);
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
  }

}

