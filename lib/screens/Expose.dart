import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lastgiget/screens/FavoriteScreen.dart';
import 'package:lastgiget/screens/chatsPage.dart';

import '../model/User.dart';
import '../widget/NavBar.dart';

class Expose extends StatefulWidget {
  const Expose({Key? key,required this.update}) : super(key: key);
final ValueChanged<int> update;
  @override
  State<Expose> createState() => _ExposeState();
}

class _ExposeState extends State<Expose> {
  final current_user = FirebaseAuth.instance.currentUser!;
  int items_nbr = 0;
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
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          widget.update(2);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  FavoriteScreen(update: widget.update,)),
          );
        } else if (details.primaryVelocity! < 0) {

        }
      },
      child: Scaffold(
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
                  child: CircularProgressIndicator(
                    color: Color(0xFF00F0FF),
                  ),
                ),
              );
            }
          },
        ),
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

              Container(
                height: 100,
                width: 100,
                //  color: Color(0xff00F0FF),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,



                  image:  DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(usr.photo),
                  ),
                ),


              ),


              // CircleAvatar(
              //   radius: 50,
              //   child: ClipRRect(
              //
              //
              //       borderRadius: BorderRadius.circular(100),
              //       child: CachedNetworkImage(
              //           imageUrl:usr.photo
              //       )),
              // ),
              SizedBox(
                height: 15,
              ),
              Text(
                usr.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,

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
                  fontSize: 12,
                  //fontWeight: FontWeight.bold,

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
                  style: TextStyle(fontSize: 16),
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
         getGridById(current_user.uid)
        ],
      ),
    );
  }

  Widget getGridById(String id) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      // inside the <> you enter the type of your stream
      stream: FirebaseFirestore.instance
          .collection("Inserat")
          .where('id_user', isEqualTo: id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          items_nbr = snapshot.data!.docs.length;
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
                          padding: EdgeInsets.all( 16),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    snapshot.data!.docs[index].get('name'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11, ),
                                  )),

                            ],
                          ),
                        )
                      ),

                      child: FittedBox(
                        //    child: Image.network(snapshot.data!.docs[index].get('photo')),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data!.docs[index].get('photo'),
                        ),

                        fit: BoxFit.fill,
                      ),
                      // child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(40),
                      //     child: CachedNetworkImage(
                      //         imageUrl:
                      //             snapshot.data!.docs[index].get('photo'))),
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
