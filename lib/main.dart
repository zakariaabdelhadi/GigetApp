//import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lastgiget/api/Notification_api.dart';
import 'package:lastgiget/screens/login.dart';
import 'firebase_options.dart';
import 'package:badges/badges.dart';

import 'package:lastgiget/screens/Splash.dart';

late String myId ;
late String myUsername;
late String myUrlAvatar;



Future main() async {





  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotification();

  getUserData();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    theme: ThemeData( textTheme: GoogleFonts.getTextTheme(
      'Inter',
    ).apply(bodyColor: Color(0xff676767),displayColor: Color(0xff676767))),
    title: 'Flutter Demo',
    home: Scaffold(
      //  body:  Versuch(),
      body:SplashView(),

    ),
  ));
}


void getUserData() {


   if( FirebaseAuth.instance.currentUser == null){
     // myId='9gne8bt1SkMw8nStunaoyzG78TC2' ;
     // myUsername='zakaria';
     // myUrlAvatar='https://firebasestorage.googleapis.com/v0/b/gigetlastversion.appspot.com/o/zakaria.jfif?alt=media&token=5cc59f72-7f75-4394-a214-2e5feeb4a3f6';
   }else{
     final current_user = FirebaseAuth.instance.currentUser!;
     CollectionReference collectionReference =
     FirebaseFirestore.instance.collection('Userss');


     collectionReference.doc(current_user.uid).get().then((value) {
       //'value' is the instance of 'DocumentSnapshot'
       //'value.data()' contains all the data inside a document in the form of 'dictionary'
       var fields= value;

       //name, image, quantity are the fields of document
       if(fields != null){

         myId = fields['id_user'];
         myUsername = fields['name'];
         myUrlAvatar = fields['photo'];
       }


     });






   }



}
