import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../model/userC.dart';
import '../screens/chatPage.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<UserC> users;

  const ChatBodyWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: buildChats(),
    ),
  );


  Widget buildChats() => ListView.builder(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      final user = users[index];


     if(user.idUser != FirebaseAuth.instance.currentUser!.uid )
     {
       return Container(
         height: 75,
         child:   Column(
           children: [
           // index == 1 ? Divider(color: Colors.black45,thickness: 0.2,):SizedBox(height: 0.000001,),
             ListTile(
               onTap: () {

                 //getUserData();
                _changeScreen(context,user);





               },
               leading:
               // Container(
               // height: 50,
               // width: 50,
               // //  color: Color(0xff00F0FF),
               // decoration: BoxDecoration(
               // shape: BoxShape.circle,
               //
               //
               //
               // image:  DecorationImage(
               // fit: BoxFit.fill,
               // image: NetworkImage(user.urlAvatar),
               // ),
               // ),
               //
               //
               // ),
               CircleAvatar(
                 radius: 25,
                 child: ClipRRect(

                     borderRadius: BorderRadius.circular(50),
                     child: CachedNetworkImage(
                         imageUrl:user.urlAvatar
                     )),
               ),

               title: Text(user.name),
             ),
             Divider(color: Colors.black45,thickness: 0.2,)
           ],
         ),
       );
     }else{return SizedBox(height: 0.01,);}

    },
    itemCount: users.length,
  );


  void _changeScreen(BuildContext context,UserC user){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ChatPage(user: user),
    ));
  }
}