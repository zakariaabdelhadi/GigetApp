import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../model/User.dart';

class Expose extends StatefulWidget {
  const Expose({Key? key}) : super(key: key);

  @override
  State<Expose> createState() => _ExposeState();
}

class _ExposeState extends State<Expose> {
  final current_user = FirebaseAuth.instance.currentUser!;

  final List<String> _list = [
    "Electronics",
    "Furniture",
    "Books",
  ];

  Future<User_Model?> readUser() async {
    final docUuser =
        FirebaseFirestore.instance.collection("Users").doc(current_user.uid);
    final snapshot = await docUuser.get();

    if (snapshot.exists) {
      return User_Model.fromJson(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User_Model?>(
        future: readUser(),
        builder: (cotext, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            return user == null
                ? Center(
                    child: Text('No user yet'),
                  )
                : buildExpose(user);
          } else {
            return Center(
              child: Container(
                child: CircularProgressIndicator(color: Color(0xFF00F0FF),),
              ),
            );
          }
        },
      ),
    );

    //
  }

  Widget buildExpose(User_Model usr) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
      CircleAvatar(

        backgroundImage:NetworkImage(usr.photo),
        radius: 35,
      ),
              SizedBox(
                height: 15,
              ),
              Text(
                usr.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.star, color: Colors.black),
                  Icon(Icons.star, color: Colors.black),
                  Icon(Icons.star, color: Colors.black),
                  Icon(Icons.star, color: Colors.black),
                  Icon(Icons.star_border, color: Colors.black),
                ],
              ),
              const Text(
                'Berlin',
                style: TextStyle(
                  fontSize: 10,
                  //fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "I am looking for",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < _list.length; i++)
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Color(0xff80E07E),
                                        style: BorderStyle.solid),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Text(
                                  _list[i],
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                            ],
                          )
                      ]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        //  GridListDemo(type: GridListDemoType.footer),
        ],
      ),
    );
  }
}
