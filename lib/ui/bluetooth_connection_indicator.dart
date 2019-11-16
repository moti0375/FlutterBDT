import 'package:bluetooth_data_terminal/model/bt_connection_state.dart';
import 'package:flutter/material.dart';

class BluetoothConnectionIndicator extends StatelessWidget {
  final AppBtConnectionState state;
  BluetoothConnectionIndicator({this.state});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildConnectionIndicator(state)
    );
  }

  Icon _buildConnectionIndicator(AppBtConnectionState state) {
    switch(state){
      case AppBtConnectionState.Disconnected: {
        return Icon(Icons.bluetooth, color: Colors.black12,);
      }
      case AppBtConnectionState.Connected:
        return Icon(Icons.bluetooth_connected, color: Colors.blue,);
      case AppBtConnectionState.Connecting:
        return Icon(Icons.bluetooth_searching, color: Colors.blueGrey,);
      case AppBtConnectionState.Scanning:
        return Icon(Icons.bluetooth_searching);
    }
    return Icon(Icons.bluetooth);
  }
}
