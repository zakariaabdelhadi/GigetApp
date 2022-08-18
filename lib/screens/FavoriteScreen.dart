import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lastgiget/screens/Expose.dart';
import 'package:lastgiget/screens/chatsPage.dart';

import '../widget/NavBar.dart';

//import '../model/User.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key,required this.update}) : super(key: key);
  final    ValueChanged<int> update;


  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final current_user = FirebaseAuth.instance.currentUser!;
  List<String> list_inserat=[];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          widget.update(1);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ChatsPage(update: widget.update,)),
          );
        } else if (details.primaryVelocity! < 0) {
          widget.update(3);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Expose(update: widget.update,)),
          );
        }
      },
      child: Material(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Favorite Articles',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,

                        color: Colors.black),
                  ),
                )
              ],
            ),
            Divider(),
            myGridd(),
          ],
        ),
      ),
    );
  }

  Widget myGridd() {

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      // inside the <> you enter the type of your stream
      stream: FirebaseFirestore.instance
          .collection("Favorite")
          .where('id_user', isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // final double itemHeight = (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
          // final double itemWidth = MediaQuery.of(context).size.width / 2;
          return GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.5),
            itemBuilder: (BuildContext context, int index) {



              return Card(

                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.only(top: 5,bottom: 5,right: 15,left: 15),
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: GestureDetector(
                    onTap: () {

                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //     content: Text(snapshot.data!.docs[index]
                      //         .get('name')
                      //         .toString())));
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
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    snapshot.data!.docs[index]['name'],
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        //       fontWeight: FontWeight.bold,
                                        color: Color(0xffFFF8F8),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      child: FittedBox(
                          // child: Image.network(snapshot.data!.docs[index].get('photo')),
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