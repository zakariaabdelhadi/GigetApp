import 'package:flutter/material.dart';

import '../api/Notification_api.dart';
import '../api/firebase_api.dart';
import '../main.dart';
import '../model/Message.dart';

import 'package:rxdart/rxdart.dart';

import '../screens/login.dart';
import 'messageWidget.dart';


class MessagesWidget extends StatelessWidget {
  final String idUser;

  const MessagesWidget({
    required this.idUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
    stream: FirebaseApi.getMessages(idUser),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());
        default:
          if (snapshot.hasError) {
            return buildText('Something Went Wrong Try later');
          } else {
            final messages = snapshot.data;

            return messages!.isEmpty
                ? buildText('Say Hi..')
                : ListView.builder(
              physics: BouncingScrollPhysics(),
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                // Duration diff=DateTime.now().difference(message.createdAt);
                //
                // if (diff.inSeconds < 3 && message.idUser != myId){
                //   print('------------------zkkk----------------------------------------'+diff.inSeconds.toString());
                //    NotificationService().Display(message.username.toString(),message.message.length >15 ? message.message.substring(1,15)+' ...':message.message,message.urlAvatar,message.urlAvatar);
                //
                //

                //}



                return MessageWidget(
                  message: message,
                  isMe: message.idUser == myId,
                );
              },
            );
          }
      }
    },
  );

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24),
    ),
  );
}