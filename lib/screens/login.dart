import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lastgiget/screens/Splash.dart';
import 'package:lastgiget/widget/NavBar.dart';

import '../api/Notification_api.dart';
import '../main.dart';





class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final mailcontrol = TextEditingController();

  final passwordcontrol = TextEditingController();
  late StreamSubscription<QuerySnapshot> sub;
  late List<DocumentSnapshot> snap;

  late CollectionReference collect =
  FirebaseFirestore.instance.collection('chats/${myId}/messages');


@override
  void initState() {
  listenStream();
  getUserData();
  super.initState();
  }
  void listenStream() {
    sub = collect.snapshots().listen((event) {
      snap = event.docs;
      for(int i=1;i<snap.length;i++){

        Duration diff=DateTime.now().difference(snap[i]['createdAt'].toDate());

        if (diff.inSeconds < 10 ){
          setState(() {
            SplashView.counter_notif++;

          });
          print('------------------zkkk------------------'+diff.inSeconds.toString());
           NotificationService().Display(snap[i]['name'].toString(),snap[i]['message'].length >15 ? snap[i]['message'].substring(1,15)+' ...':snap[i]['message'],snap[i]['photo'],snap[i]['photo']);



        }

      }
      // print(snap['message']);
      // print('rani f listening -----------------------------------');
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NavBar();
            } else {}
            return login_screen();
          },
        ));
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mailcontrol.text.trim(),
          password: passwordcontrol.text.trim());
    } on FirebaseAuthException catch (e) {
      // TODO
    }
  }

///////////

  Widget login_screen() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 350,
              decoration: BoxDecoration(),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/lampe.png'))),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 120,
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Container(
                            child:
                              Image.asset('assets/images/logo.PNG')
                            // Text(
                            //   "GiGet",
                            //   style: TextStyle(
                            //       fontFamily: 'cookie',
                            //       fontSize: 82,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.black),
                            // ),
                          ),
                          radius: 80,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

/////////////////////////////////////// partie des champes de saisie /////////////////////////////
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black))),
                          child: TextField(
                            controller: mailcontrol,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email ",
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: passwordcontrol,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      signIn();

                       getUserData();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF80E07E),
                              Color(0xFF00F0FF),
                            ],
                          )),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black45),
                      ),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }





}
