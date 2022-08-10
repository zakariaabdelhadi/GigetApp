import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'djitMenNotif.dart';
import 'login.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(Duration(seconds: 2), _changeScreen);
  }

  _changeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();

   // initialiseLocalNotif();

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          //color: Colors.black26,
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Color(0xFF80E07E),
          //     Color(0xFF00F0FF),
          //   ],
          // ),
          color: Colors.black,
          // color: Color(0xFF00F0FF),
          ),
      child: //  backgroundColor: Color(0xFF80E07E),
          Center(
              child: Container(
        height: 200,
        width: 200,
      //  color: Color(0xff00F0FF),
        decoration: BoxDecoration(
          shape: BoxShape.circle,


         // color: Colors.blueAccent,
          border: Border.all(
            color: Color(0xff00F0FF),
            width: 10.0,
            //    style: BorderStyle.solid
          ),
          // image:  DecorationImage(
          //   fit: BoxFit.contain,
          //   image: AssetImage('assets/images/ic_launcher.png') as ImageProvider,
          // ),
        ),
        child: Center(
          child: Text(
            'Giget',
            style: TextStyle(
              color: Color(0xff00F0FF),
                fontFamily: 'cookie',
                fontWeight: FontWeight.bold,
                fontSize: 48),
          ),
        ),
      )),
    );
  }

  Future<void> initialiseLocalNotif() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
   // final IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  //  final MacOSInitializationSettings initializationSettingsMacOS =
   // MacOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
       // iOS: initializationSettingsIOS,
        //macOS: initializationSettingsMacOS
        );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => DjitNotif( Payload: payload!,)),
    );
  }
}
