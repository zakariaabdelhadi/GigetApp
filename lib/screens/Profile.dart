import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lastgiget/model/userC.dart';

import '../model/User.dart';
import 'chatPage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required String this.id_user}) : super(key: key);

  final String id_user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final current_user = FirebaseAuth.instance.currentUser!;
  int items_nbr = 0;
  late UserC inhaber;

  List<String> list_carousel = [];

  late StreamSubscription<QuerySnapshot> subscription;
  late List<DocumentSnapshot> snapshot;
  late DocumentSnapshot snap_non_list;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Inserat");

  final List<String> _list = [
    "Electronics",
    "Furniture",
    "Textile",
    "Video Games",
    "Books",
    "Küchensachen",
    "Garnicht danke !"
  ];
  final String txt =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  void initState() {
    subscription = collectionReference.snapshots().listen((event) {
      setState(() {
        snapshot = event.docs;
      });
    });
    super.initState();
  }

  Future<User_Model?> readUser() async {
    final docUuser =
        FirebaseFirestore.instance.collection("Users").doc(widget.id_user);
    final snapshot = await docUuser.get();

    if (snapshot.exists) {
      return User_Model.fromJson(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          FutureBuilder<User_Model?>(
            future: readUser(),
            builder: (cotext, snapshot) {
              if (snapshot.hasData) {
                final user = snapshot.data;
                if (user != null) {
                  inhaber = UserC(
                      idUser: widget.id_user,
                      name: user.name,
                      urlAvatar: user.photo,
                      lastMessageTime: DateTime.now());
                                 }

                return user == null
                    ? Center(
                        child: Text('No user yet'),
                      )
                    : buildUser1(user);
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

          getGridById(widget.id_user),
          showButton(),

          /////////////////
        ],
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////////////
  Widget buildUser1(User_Model usr) {

    return //Text(snapshot[0]['name']),
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          //  alignment: const Alignment(-1,1),
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: carousel(),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: BackButton(
                //  Icons.close,
                color: Colors.black,
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            Positioned(
              bottom: 0,
              // right: ,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                decoration: BoxDecoration(
                    //color: Colors.black26,
                    gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black26,
                    Colors.transparent,
                  ],
                )),
                // width: double.infinity,
                child: Row(
                  children: [

                    // Container(
                    // height: 70,
                    // width: 70,
                    // //  color: Color(0xff00F0FF),
                    // decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    //
                    //
                    //
                    // image:  DecorationImage(
                    // fit: BoxFit.fill,
                    // image: NetworkImage(usr.photo),
                    // ),
                    // ),
                    //
                    //
                    // ),

                    CircleAvatar(
                      radius: 35,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: CachedNetworkImage(imageUrl: usr.photo)),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: const BoxDecoration(
                          //color: Colors.black45,
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            usr.name,
                            style: GoogleFonts.getFont(
                              'Inter',
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFFF8F8),
                              ),
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star, color: Colors.white),
                              Icon(Icons.star_border, color: Colors.white),
                            ],
                          ),
                          Text(
                            'Berlin',
                            style: GoogleFonts.getFont(
                              'Inter',
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFFF8F8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text("Vinted cabinet",
                  style: GoogleFonts.getFont(
                    'Inter',
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff676767),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                txt,
                style: GoogleFonts.getFont(
                  'Inter',
                  textStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0xff676767),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                usr.name + ' is looking for',
                style: GoogleFonts.getFont(
                  'Inter',
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff676767),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                child: Column(children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Text(
                                    _list[i],
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff676767),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                              ],
                            )
                        ]),
                  ),
                ]),
              ),

              //   GridListDemo(type: GridListDemoType.footer),
              const SizedBox(
                height: 15,
              ),
              Text(
                "${usr.name} closet",
                style: GoogleFonts.getFont(
                  'Inter',
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff676767),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    //  GridListDemo(type: GridListDemoType.footer),
  }

  Widget showButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      //decoration: BoxDecoration(),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 40,
          width: 140,
          child: TextButton(
              child: Text("Chat".toUpperCase(), style: TextStyle(fontSize: 14)),
              style: ButtonStyle(

                  // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff80E07E)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Color(0xff80E07E))))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(user: inhaber)),
                );
              }),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 40,
          width: 140,
          child: ElevatedButton(
              child: Text("Swap".toUpperCase(), style: TextStyle(fontSize: 14)),
              style: ButtonStyle(

                  //     padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff80E07E)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Color(0xff80E07E))))),
              onPressed: () {
                showOverlay(context);
              }),
        )
      ]),
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
              list_carousel
                  .add(snapshot.data!.docs[index].get('photo').toString());

              return Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: GestureDetector(
                    onTap: () {
                      showOverlay(context);
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
                                snapshot.data!.docs[index].get('name'),
                                style: GoogleFonts.getFont(
                                  'Inter',
                                  textStyle: TextStyle(
                                    fontSize: 11,
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
                        //    child: Image.network(snapshot.data!.docs[index].get('photo')),
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

//////////////////////////////////////////////////////////

  Widget carousel() {
    return CarouselSlider(
      options: CarouselOptions(
        // height: 400.0,
        aspectRatio: 1,

        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
      ),
      items: list_carousel.map((i) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 0),
          margin: EdgeInsets.symmetric(horizontal: 0),
          child: Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                // padding: EdgeInsets.symmetric(horizontal: 5),
                // margin: EdgeInsets.symmetric(horizontal: 0),
                // decoration: BoxDecoration(
                //color: Colors.black26,
                // ),
                //child:Image.asset(i,fit:  BoxFit.fill ),
                // child: ClipRRect(
                //     borderRadius: BorderRadius.circular(0),
                //     child: CachedNetworkImage(imageUrl: i)),
                child: FittedBox(
                  //  child: Image.network(i),
                  child: CachedNetworkImage(imageUrl: i),

                  fit: BoxFit.fill,
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Future<void> showOverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    late OverlayEntry overlay1;
    OverlayEntry overlay2;
    OverlayEntry overlay3;
    overlay1 = OverlayEntry(builder: (context) {
      return Positioned(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color: Color(0xFF00F0FF).withOpacity(0.5),
            color: Colors.black54,
          ),
          margin: EdgeInsets.all(50),
          child: Material(
            color: Colors.transparent,
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white30,
                  child: Center(
                    child: IconButton(
                      highlightColor: Colors.black,
                      onPressed: () {
                        overlay1.remove();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                getGridById(current_user.uid),
              ],
            ),
          ),
        ),
      );
    });

    overlayState?.insertAll([overlay1]);

    // await Future.delayed(const Duration(seconds: 6));
    // overlay1.remove();
    // await Future.delayed(const Duration(seconds: 10));
    // overlay2.remove();
  }
}
