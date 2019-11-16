import 'dart:async';

import 'package:bluetooth_data_terminal/model/bt_connection_state.dart';

abstract class BluetoothConnectionBase {
  Future<void> scanAndConnect(String deviceName);
  Future<void> cancelScan();
  Future<void> disconnectDevice();
  Stream<TerminalDataModel> getConnectionStream();
  void dispose();
}
