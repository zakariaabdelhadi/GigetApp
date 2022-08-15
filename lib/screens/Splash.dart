import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../api/Notification_api.dart';
import '../main.dart';
import 'login.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  static int counter_notif=0;


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
    getUserData();

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
          color: Colors.white,
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



          image:  DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/logo.PNG') as ImageProvider,
          ),
        ),
        // child: Center(
        //   child: Image.asset('assets/images/logo.PNG'),
        // ),
      )),
    );
  }


}
