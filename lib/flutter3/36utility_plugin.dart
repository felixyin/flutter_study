import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:battery/battery.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'dart:async';
import 'dart:io';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// 电池电量
  Battery _battery = Battery();
  StreamSubscription<BatteryState> _bsStream;
  BatteryState _batteryState;

// 网络连接
  Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _crStream;
  ConnectivityResult _connectivityResult;
  String _connectionStatus = 'Unknown';

// 设备信息
  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo _androidInfo;
  IosDeviceInfo _iosInfo;

  @override
  void initState() {
    super.initState();
    initAll();

    // 电量变化，监听
    _bsStream = _battery.onBatteryStateChanged.listen((BatteryState value) {
      setState(() {
        _batteryState = value;
      });
      print(value);
    });
    // 网络连接变化，监听
    _crStream = _connectivity.onConnectivityChanged.listen((ConnectivityResult value) {
      setState(() {
        _connectionStatus = value.toString();
      });
    });
  }

  Future<Null> initAll() async {
    AndroidDeviceInfo androidInfo;
    IosDeviceInfo iosInfo;
    if (Platform.isAndroid) {
      androidInfo = await _deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
    } else if (Platform.isIOS) {
      iosInfo = await _deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}'); //
    }
    setState(() {
      _androidInfo = androidInfo;
      _iosInfo = iosInfo;
    });

    String connectionStatus;
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }
    if (!mounted) return;
    setState(() {
      _connectionStatus = connectionStatus;
    });
  }

  @override
  void dispose() {
    _bsStream?.cancel();
    _crStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = <Widget>[
      Text(_batteryState.toString()),
      Text(_connectionStatus),
    ];
    if (_androidInfo != null) {
      _list.addAll(<Widget>[
        Text("Device Id: ${_androidInfo.id}"),
        Text("Device FingerPrint: ${_androidInfo.fingerprint}"),
        Text("Device Model: ${_androidInfo.model}"),
        Text("Device Brand: ${_androidInfo.brand}"),
      ]);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Utility Plugin'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: _list,
          ),
        ),
      ),
    );
  }
}
