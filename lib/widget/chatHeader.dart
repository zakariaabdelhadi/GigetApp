import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/userC.dart';

import '../screens/chatsPage.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<UserC> users;

  const ChatHeaderWidget({
    required this.users,
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    width: double.infinity,
    child: Row(
     mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BackButton(
          //  Icons.close,
          color: Colors.white,
          onPressed: () {

            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pop(context);

            }
          },
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: const Text(
            'Start messaging with Giget Comunity',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'cookie',

              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Container(
        //   height: 60,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: users.length,
        //     itemBuilder: (context, index) {
        //       final user = users[index];
        //
        //       if(user.idUser != FirebaseAuth.instance.currentUser!.uid ) {
        //          return Container(
        //            margin: const EdgeInsets.only(right: 12),
        //            child: GestureDetector(
        //              onTap: () {
        //                // Navigator.of(context).push(MaterialPageRoute(
        //                //   builder: (context) => ChatPage(user: users[index]),
        //                // ));
        //              },
        //              child: CircleAvatar(
        //                radius: 24,
        //                backgroundImage: NetworkImage(user.urlAvatar),
        //              ),
        //            ),
        //          );
        //        }else{
        //          return SizedBox(height: 0.1,);
        //        }
        //
        //     },
        //   ),
        // )
      ],
    ),
  );
}