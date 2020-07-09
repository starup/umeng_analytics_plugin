import 'dart:async';

import 'package:flutter/material.dart';
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  var _tdv;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var result = await UmengAnalyticsPlugin.init(
      androidKey: '5dfc5b91cb23d26df0000a90',
      iosKey: '5dfc5c034ca35748d1000c4c',
    );

    print('Umeng initialized.');

    _tdv = await UmengAnalyticsPlugin.getTestDeviceInfo();
    print('tdv=$_tdv');

    if (!mounted) {
      return;
    }

    setState(() {
      _platformVersion = result ? 'OK' : 'ERROR';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              Text('deviceInfo: $_tdv\n'),
              FlatButton(
                child: Text('click'),
                onPressed: () {
                  UmengAnalyticsPlugin.event('click', label: '测试点击');
                },
              ),
            ],
          ),
          
        ),
      ),
    );
  }
}
