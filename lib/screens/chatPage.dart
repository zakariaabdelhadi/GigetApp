import 'package:flutter/material.dart';

import '../model/userC.dart';
import '../widget/NewMessageWidget.dart';
import '../widget/Profile_header.dart';
import '../widget/messagesWidget.dart';

class ChatPage extends StatefulWidget {
  final UserC user;

  const ChatPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        //  backgroundColor: Colors.blueGrey,

        body: Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //     colors: [Color(0xff80E07E), Color(0xff00F0FF)],
            //     begin: Alignment.centerLeft,
            //     end: Alignment.centerRight),
          ),
          child: SafeArea(
            child: Column(
              children: [
                ProfileHeaderWidget(
                    name: widget.user.name, photo: widget.user.urlAvatar),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: MessagesWidget(idUser: widget.user.idUser),
                  ),
                ),
                NewMessageWidget(idUser: widget.user.idUser)
              ],
            ),
          ),
        ),
      );
}
