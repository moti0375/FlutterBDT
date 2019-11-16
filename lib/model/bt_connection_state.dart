enum AppBtConnectionState{
  Connected, Connecting, Disconnected, Scanning
}

class AppBtDevice{
  final String name;
  final String id;
  final AppBtConnectionState state;
  AppBtDevice({this.name, this.id, this.state});
}

class AppScanResult{
  final AppBtDevice device;
  final int rssi;
  AppScanResult({this.device, this.rssi});
}

class TerminalDataModel{
  final String row1;
  final String row2;
  final AppBtConnectionState connectionState;

  TerminalDataModel({this.row1 = "", this.row2 = "", this.connectionState = AppBtConnectionState.Disconnected});

  TerminalDataModel updateWith({String row1, String row2, AppBtConnectionState connectionState}){
    return TerminalDataModel(
      row1: row1 ?? this.row1,
      row2: row2 ?? this.row2,
      connectionState: connectionState ?? this.connectionState
    );
  }
}

