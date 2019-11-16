import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bluetooth_data_terminal/bluetooth/ConnectionBase.dart';
import 'package:bluetooth_data_terminal/model/bt_connection_state.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart'
    as prefix0;
import 'package:rxdart/rxdart.dart';

class FlutterSerialService extends BluetoothConnectionBase {
  FlutterBluetoothSerial _bluetoothSerial = FlutterBluetoothSerial.instance;
  BehaviorSubject<TerminalDataModel> _connectionStream =
      BehaviorSubject.seeded(TerminalDataModel());
  Map<String, prefix0.BluetoothDevice> _devices = Map();
  List<int> buffer = List();
  BluetoothConnection _connection;



  @override
  Future<void> cancelScan() {
    // TODO: implement cancelScan
    return null;
  }

  @override
  Future<void> disconnectDevice() {
    // TODO: implement disconnectDevice
    return null;
  }

  @override
  void dispose() {
    print("Dispose: ");

    if(_connection != null && _connection.isConnected){
      _connection.close();
      _connection = null;
    }

    _bluetoothSerial.cancelDiscovery();
    _connectionStream.close();
    _connectionStream = null;
  }

  @override
  Stream<TerminalDataModel> getConnectionStream() {
    return _connectionStream;
  }

  @override
  Future<void> scanAndConnect(String deviceName) async {
    List<prefix0.BluetoothDevice> devices =
        await _bluetoothSerial.getBondedDevices();
    // ignore: missing_return
    print("Devices: ${devices.toString()}");
    prefix0.BluetoothDevice device = devices.firstWhere((it) {
      return it.name == deviceName;
    });

    if (device != null) {
      _connectDevice(device);
    }
    return null;
  }

  void _connectDevice(prefix0.BluetoothDevice device) async {
    print("Connecting to device: ${device.name}");
    _updateConnectionState(AppBtConnectionState.Connecting);
    _connection = await BluetoothConnection.toAddress(device.address);
    _connectionStream.add(_connectionStream.value.updateWith(connectionState: AppBtConnectionState.Connected));
    _connection.input.listen((Uint8List data) {
      _processInputData(data);
    }).onDone(() {
      print("onDone");
      dispose();
    });
  }

  void _updateConnectionState(AppBtConnectionState connectionState) {
    _connectionStream.add(_connectionStream.value.updateWith(connectionState: connectionState));
  }

  void _processInputData(Uint8List data) {
    String upperRow = "";
    String bottomRow = "";

    data.forEach((it){
      if(it != 252 && it != 253){
        buffer.add(it);
      } else {
        if(it == 253) {
          List<int> buffer2 = new List<int>(buffer.length);
          for (int i = 0; i < buffer.length; i++) {
            if(buffer.length > 33){
              buffer2[i] = ((buffer[i]) ^ 0xff) + buffer[33];
              buffer2[i] = buffer2[i] & 0xff;
              if (buffer2[i] == 223) {
                buffer2[i] = 176;
              }
            }
          }

          if (buffer2.length > 40) {
            for (int i = 0; i < 16; i++) {
              upperRow = "$upperRow${String.fromCharCode(buffer2[i])}";
              bottomRow = "$bottomRow${String.fromCharCode(buffer2[i + 16])}";
            }
            print("1'st Row: $upperRow");
            print("2'nd Row: $bottomRow");
            _connectionStream.add(_connectionStream.value.updateWith(
                row1: upperRow, row2: bottomRow));
          }
          buffer.clear();
        }
      }
    });
  }

}
