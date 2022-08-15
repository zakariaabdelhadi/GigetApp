import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import '../model/User.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);


  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final current_user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Favorite Articles',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cookie',
                      color: Colors.black),
                ),
              )
            ],
          ),
          Divider(),
          myGridF()
        ],
      ),
    );
  }

  Widget myGrid() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      // inside the <> you enter the type of your stream
      stream: FirebaseFirestore.instance
          .collection("Inserat")
          .where('category', isEqualTo: 'Textile')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(snapshot.data!.docs[index]
                              .get('name')
                              .toString())));
                    },
                    child: new GridTile(
                      footer: Material(
                        color: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(4)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black,
                                Colors.transparent,
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    snapshot.data!.docs[index].get('name'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),

                            ],
                          ),
                        ),
                      ),
                      child: FittedBox(
                        // child:
                        // Image.network(
                        //     snapshot.data!.docs[index].get('photo')),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data!.docs[index].get('photo'),
                        ),

                        fit: BoxFit.fill,
                      ),
                      //just for testing, will fill with image later
                    ),
                  ),
                ),
              );
            },
          );
        }

        if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget myGridF() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      // inside the <> you enter the type of your stream
      stream: FirebaseFirestore.instance
          .collection("Favorite")
          .where('id_user',
          isEqualTo: FirebaseAuth.instance.currentUser?.uid.toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            // inside the <> you enter the type of your stream
            //snapshot.data!.docs[index].id
            stream: FirebaseFirestore.instance
                .collection("Inserat")
               .where('category', isEqualTo: 'Textile')
               .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return
                  GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1),
                    itemBuilder: (BuildContext context, int index) {
                      return new Card(
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: new GridTile(
                              footer: Material(
                                color: Colors.transparent,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.vertical(
                                      bottom: Radius.circular(4)),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black,
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                            snapshot.data!.docs[index].get(
                                                'name'),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )),

                                    ],
                                  ),
                                ),
                              ),
                              child: FittedBox(

                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.docs[index].get(
                                      'photo'),
                                ),

                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
              }

              if (snapshot.hasError) {
                return const Text('Error');
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        }

        if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

// GridView.builder(
// shrinkWrap: true,
// physics: ScrollPhysics(),
// itemCount: snapshot.data!.docs.length,
// gridDelegate:
// SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
// itemBuilder: (BuildContext context, int index) {
// return new Card(
// elevation: 20,
// child: Padding(
// padding: const EdgeInsets.all(3.0),
// child: GestureDetector(
// onTap: () {
//
// },
// child: new GridTile(
// footer: Material(
// color: Colors.transparent,
// shape: const RoundedRectangleBorder(
// borderRadius:
// BorderRadius.vertical(bottom: Radius.circular(4)),
// ),
// clipBehavior: Clip.antiAlias,
// child:Container(
// decoration: BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.bottomCenter,
// end: Alignment.topCenter,
// colors: [
// Colors.black,
// Colors.transparent,
// ],
// ),
// ),
// padding: EdgeInsets.all( 8),
// child: Row(
// children: [
// Expanded(
// child: Text(
// snapshot.data!.docs[index].get('name'),
// style: TextStyle(
// color: Colors.white,
// fontSize: 14, fontWeight: FontWeight.bold),
// )),
//
// ],
// ),
// ),
// ),
// child: FittedBox(
// // child:
// // Image.network(
// //     snapshot.data!.docs[index].get('photo')),
// child: CachedNetworkImage(
// imageUrl: snapshot.data!.docs[index].get('photo'),
// ),
//
// fit: BoxFit.fill,
// ),
// //just for testing, will fill with image later
// ),
// ),
// ),
// );
// },
// );