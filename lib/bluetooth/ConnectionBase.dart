import 'dart:async';

import 'package:bluetooth_data_terminal/model/bt_connection_state.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:rxdart/rxdart.dart';

abstract class ConnectionBase {
  Future<void> scanAndConnect(String deviceName);

  Future<void> cancelScan();

  Future<void> disconnectDevice();

  Stream<TerminalDataModel> getConnectionStream();

  void dispose();
}

class FlutterBluService implements ConnectionBase {
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  BehaviorSubject<TerminalDataModel> _connectionStream =
      BehaviorSubject.seeded(TerminalDataModel());

  BluetoothDevice _connectedDevice;
  StreamSubscription<ScanResult> scanSubscription;
  Map<String, BluetoothDevice> _devices = Map();

  @override
  Stream<TerminalDataModel> deviceDataStream() {
    // TODO: implement deviceDataStream
    return null;
  }

  @override
  Future<void> disconnectDevice() async {
    await _connectedDevice.disconnect();
    return;
  }

  @override
  Future<void> scanAndConnect(String deviceName) {
    scanSubscription = _flutterBlue
        .scan()
        .listen((result) {
          print("ScanResult: ${result.device.id} : ${result.device.name}");
          if (result.device.name.toLowerCase() == deviceName.toLowerCase()) {
            _connectDevice(result.device);
          }
        });
    _updateConnectionState(AppBtConnectionState.Scanning);
    return null;
  }

  @override
  Future<void> cancelScan() {
    _flutterBlue.stopScan();
    return null;
  }

  @override
  void dispose() {
    _flutterBlue.stopScan();
    _connectionStream.close();
    _connectionStream = null;
    scanSubscription.cancel();
    scanSubscription = null;
  }

  void _startConnectionListener(BluetoothDevice device){
    device.state.listen((connectionState){
      print("ConnectionListener: ${connectionState.toString()}");
      if(connectionState == BluetoothDeviceState.connected){
        _updateConnectionState(AppBtConnectionState.Connected);
        pauseScan();
      } else {
        _updateConnectionState(AppBtConnectionState.Disconnected);
        resumeScan(device);
      }
    });
  }
  void pauseScan(){
    print("Pause Scan");
    scanSubscription.pause();
  }

  void resumeScan(BluetoothDevice device){
    print("Resume BT scanning");
    if(scanSubscription == null){
      _startConnectionListener(device);
    } else {
      if(scanSubscription.isPaused){
        scanSubscription.resume();
      }
    }
    _updateConnectionState(AppBtConnectionState.Scanning);
  }

  void _connectDevice(BluetoothDevice device) async {
    _updateConnectionState(AppBtConnectionState.Connecting);
    await device.connect().then((_){
      _startConnectionListener(device);
    });

  }
  void _updateConnectionState(AppBtConnectionState connectionState) {
    _connectionStream.add(_connectionStream.value.updateWith(connectionState: connectionState));
  }

  @override
  Stream<TerminalDataModel> getConnectionStream() {
    return _connectionStream.stream;
  }
}
