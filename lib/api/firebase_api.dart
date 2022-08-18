import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../main.dart';
import '../model/Message.dart';
import '../model/userC.dart';
import '../utils.dart';

import 'package:rxdart/rxdart.dart';

class FirebaseApi {
  final current_user = FirebaseAuth.instance.currentUser!;

  static Stream<List<UserC>> getUsers() => FirebaseFirestore.instance
      .collection('Userss')
      //.orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(UserC.fromJson));

  static Future uploadMessage(String idUser, String message) async {
    final refMessages = FirebaseFirestore.instance.collection(
        'chats/$idUser/messages'); // l id ta3 elli etteb3et lih l msg

    final newMessage = Message(
      idUser: myId,
      // c est chkoun b3et l msg
      urlAvatar: myUrlAvatar,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('Userss');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String idUser) {
    var chat1 = FirebaseFirestore.instance
        .collection(
          'chats/${idUser}/messages',
        )
        .where('id_user', isEqualTo: FirebaseAuth.instance.currentUser!.uid)

        //where('id_user',isEqualTo: idUser)
        .orderBy(MessageField.createdAt, descending: true)
        .snapshots()
        .transform(Utils.transformer(Message.fromJson));

    var chat2 = FirebaseFirestore.instance
        .collection(
          'chats/${FirebaseAuth.instance.currentUser!.uid}/messages',
        )
        .where('id_user', isEqualTo: idUser)
        .orderBy(MessageField.createdAt, descending: true)
        .snapshots()
        .transform(Utils.transformer(Message.fromJson));

    return Rx.combineLatest2(
        chat1, //a snapshot from firestore
        chat2, //another snapshot from firestore
        (List<Message> stream1, List<Message> stream2) {
      List<Message> list = stream2 + stream1;
      list.sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
      return list;
    });
  }

  static Future addRandomUsers(List<UserC> users) async {
    final refUsers = FirebaseFirestore.instance.collection('Userss');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(
            idUser: myId,
            urlAvatar: myUrlAvatar,
            name: myUsername,
            lastMessageTime: '');

        await userDoc.set(newUser.toJson());
      }
    }
  }
}
