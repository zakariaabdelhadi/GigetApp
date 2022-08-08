import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
// import 'package:giget/screens/add_inserat.dart';
// import 'package:giget/screens/chatsPage.dart';
// import 'package:giget/screens/getCategory.dart';
// import 'package:giget/screens/try.dart';
import 'package:lastgiget/screens/Splash.dart';


// import 'material_demo_types.dart';
// import 'model/userC.dart';
// import '../../giget/lib/screens/Splash.dart';


late String myId ;
late String myUsername;
late String myUrlAvatar;
Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getUserData();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    title: 'Flutter Demo',
    home: Scaffold(
      //  body:  Versuch(),
      body:SplashView(),

    ),
  ));
}
void getUserData() {
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
      print( myUrlAvatar + myUsername + myId);
    }

    //while retrieving numerical value from firebase, convert it to string before displaying

  });



}
