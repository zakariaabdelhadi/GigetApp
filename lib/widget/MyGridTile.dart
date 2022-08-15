
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';

class MyGridTile extends StatefulWidget {
  const MyGridTile({Key? key,required this.name,required this.id_inserat}) : super(key: key);
  final String name;
  final String id_inserat;


  @override
  State<MyGridTile> createState() => _MyGridTileState();
}

class _MyGridTileState extends State<MyGridTile> {

  late bool loved;

  @override
  void initState() {
    loved=false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
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
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
              child: Text(widget.name
                ,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    ),
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  loved ? loved = false : loved=true;
                  
                });
                loved? SaveInFavorite() : deleteFromFavorite();
                  
               
              },
              icon: loved
                  ? Icon(
                Icons.favorite_outlined,
                color: Colors.white,
              )
                  : Icon(
                Icons.favorite_border,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Future deleteFromFavorite() async {
    final docUser =
    FirebaseFirestore.instance.collection("Favorite").where('id_inserat',isEqualTo: widget.id_inserat);

    docUser.get().then((querySnapshot) {

      for(var val in querySnapshot.docs ){
        val.reference.delete();
      }


    });
    }
  Future SaveInFavorite() async {


    final id_user=FirebaseAuth.instance.currentUser?.uid;
    final id_inserat=widget.id_inserat;

    createArticleUpload(

        id_user: id_user,id_inserat: id_inserat);


  }

  Future createArticleUpload(
      {required String? id_user,
        required String id_inserat,
       }) async {
    final docUser = FirebaseFirestore.instance.collection("Favorite").doc();
    final json = {
      'id_user': id_user,
      'id_inserat': id_inserat,

    };
    await docUser.set(json);
  }

}
