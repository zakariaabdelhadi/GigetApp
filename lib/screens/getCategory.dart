import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import '../model/User.dart';

class getCategory extends StatefulWidget {
  const getCategory({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  State<getCategory> createState() => _getCategoryState();
}

class _getCategoryState extends State<getCategory> {
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
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.category,
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
          myGrid()
        ],
      ),
    );
  }

  Widget myGrid() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      // inside the <> you enter the type of your stream
      stream: FirebaseFirestore.instance
          .collection("Inserat")
          .where('category', isEqualTo: widget.category)
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
                        child: GridTileBar(
                          backgroundColor: Colors.black26,
                          title: Text(snapshot.data!.docs[index].get('name')),

                          //  subtitle:Text("tiri berk"),
                        ),
                      ),
                      child: FittedBox(
                        child: Image.network(
                            snapshot.data!.docs[index].get('photo')),
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

/*ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        snapshot.data!.docs[index].get('name'),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        snapshot.data!.docs[index].get('photo'),
                      ),
                    ),
                  ],
                );
              },
            )*/
