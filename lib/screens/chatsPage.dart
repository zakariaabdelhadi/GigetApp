
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:lastgiget/screens/Explore.dart';
import 'package:lastgiget/screens/FavoriteScreen.dart';
import 'package:lastgiget/screens/Splash.dart';

import '../api/firebase_api.dart';
import '../model/userC.dart';
import '../widget/NavBar.dart';
import '../widget/chatBody.dart';
import '../widget/chatHeader.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key,required this.update}) : super(key: key);
  final    ValueChanged<int> update;

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
     return GestureDetector(
       onHorizontalDragEnd: (DragEndDetails details) {
         if (details.primaryVelocity! > 0) {
           widget.update(0);
           Navigator.push(
             context,
             MaterialPageRoute(builder: (context) =>Explore(update:widget.update ,)),
           );
         } else if (details.primaryVelocity! < 0) {
           widget.update(2);
           Navigator.push(
             context,
             MaterialPageRoute(builder: (context) =>  FavoriteScreen(update: widget.update,)),
           );
         }
       },
       child: Scaffold(
         // backgroundColor: ui.Gradient.linear( [Color(0xffffff),Color(0xffffff)]),
          body: Container(
            decoration: BoxDecoration(
             // gradient: LinearGradient(colors:[Color(0xff80E07E),Color(0xff00F0FF)],begin: Alignment.centerLeft,end: Alignment.centerRight),
            ),
            child: SafeArea(
              child: StreamBuilder<List<UserC>>(
                stream: FirebaseApi.getUsers(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return buildText('Something Went Wrong Try later');
                      } else {
                        final users = snapshot.data;

                        if (users!.isEmpty) {
                          return buildText('No Users Found');
                        } else
                          return Column(
                            children: [
                             ChatHeaderWidget(users: users),
                              Divider(color: Colors.black45,thickness: 0.2,),

                              // AppBar(leading: IconButton(icon:Icon(Icons.search) , onPressed: () {  },),),
                              ChatBodyWidget(users: users)
                            ],
                          );
                      }
                  }
                },
              ),
            ),
          ),
        ),
     );
}

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
}
