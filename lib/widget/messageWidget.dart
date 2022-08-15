import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/Message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageWidget({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!isMe)
          CircleAvatar(
            radius: 18,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(imageUrl: message.urlAvatar)),
          ),
        // CircleAvatar(
        //   radius: 18,
        //   backgroundImage: NetworkImage(message.urlAvatar),
        // ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          constraints: BoxConstraints(maxWidth: 140),
          decoration: BoxDecoration(
            color: isMe ? Colors.black12 : Colors.black45,
            borderRadius: isMe
                ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() {
    String hour = message.createdAt.hour.toString();
    String minute = message.createdAt.minute.toString();

    if (minute.length == 1) {
      minute = "0" + minute;
    }

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          message.message,
          style: TextStyle(color: isMe ? Colors.black : Colors.white),
          textAlign: isMe ? TextAlign.end : TextAlign.start,
        ),
        Text(
          hour + ':' + minute,
          style: TextStyle(fontSize: 8),
        )
      ],
    );
  }
}
