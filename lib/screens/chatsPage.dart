
import 'package:flutter/material.dart';
import 'package:lastgiget/screens/Splash.dart';

import '../api/firebase_api.dart';
import '../model/userC.dart';
import '../widget/chatBody.dart';
import '../widget/chatHeader.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
     return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
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
                          // AppBar(leading: IconButton(icon:Icon(Icons.search) , onPressed: () {  },),),
                          ChatBodyWidget(users: users)
                        ],
                      );
                  }
              }
            },
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
