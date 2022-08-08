import 'dart:async';

import 'package:flutter/material.dart';

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
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF80E07E),
          Color(0xFF00F0FF),
        ],
      )),
      child: //  backgroundColor: Color(0xFF80E07E),
          const Center(
        child: Text(
          "GiGet",
          style: TextStyle(
              fontFamily: 'cookie',
              fontSize: 82,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    );
  }
}
