import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lastgiget/screens/Profile.dart';
import 'package:lastgiget/widget/MyGridTile.dart';
import 'getCategory.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    bool loved = false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            alignment: Alignment.centerLeft,
            // height: 50,
            //  width: 300,
            child: Text(
              "GiGet",
              style: TextStyle(
                  fontFamily: 'cookie',
                  fontSize: 50,
                  //fontWeight: FontWeight.bold,
                 color: Color(0xFF00F0FF)

        ),
            ),
          ),
          actions: <Widget>[
            // Image.asset("assets/images/komode1.png"),

            // IconButton(
            //   icon: Icon(
            //     Icons.add_circle_outline,
            //     color: Colors.black,
            //   ),
            //   onPressed: () {},
            // ),
            _insertNotif(),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        //   body: HomePage(),
        body: Explore_body(),
        //body:  GridListDemo(type: GridListDemoType.footer),
      ),
    );
  }
}

class Explore_body extends StatefulWidget {
  const Explore_body({Key? key}) : super(key: key);

  @override
  State<Explore_body> createState() => _Explore_bodyState();
}

class _Explore_bodyState extends State<Explore_body> {
  bool loved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: CupertinoColors.black,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'What are you looking for ?',
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Color(0xFF00F0FF),
                    ),
                    onPressed: () {
                      print("search icon clicked !");
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.white,
                        child: Container(
                          //  height: 40,
                          child: IconButton(
                            iconSize: 40,
                            icon: ImageIcon(
                              AssetImage("assets/images/video_games.png"),
                              color: Colors.black,
                              // size: 24,
                            ),
                            tooltip: 'Increase volume by 10',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const getCategory(category: "Games")),
                              );
                            },
                          ),
                        ),
                      ),
                      Text("Games",style: TextStyle(fontSize: 12),),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.white,
                        child: Container(
                          //  height: 40,
                          child: IconButton(
                            iconSize: 40,
                            icon: ImageIcon(
                              AssetImage("assets/images/electronics.png"),
                              color: Colors.black,
                              size: 40,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const getCategory(
                                        category: "Electronics")),
                              );
                            },
                          ),
                        ),
                      ),
                      Text("Electronics",style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.white,
                        child: Container(
                          // height: 40,
                          child: IconButton(
                            iconSize: 40,
                            icon: ImageIcon(
                              AssetImage("assets/images/Textile.png"),
                              color: Colors.black,
                              size: 40,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const getCategory(category: "Textile")),
                              );
                            },
                          ),
                        ),
                      ),
                      Text("Textile",style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.notifications_none,
                      //     color: Colors.black,
                      //   ),
                      //   onPressed: () {},
                      // ),
                      CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.white,
                        child: Container(
                          //  height: 40,
                          child: IconButton(
                            icon: ImageIcon(
                              AssetImage("assets/images/books.png"),
                              color: Colors.black,
                              size: 40,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const getCategory(category: "Books")),
                              );
                            },
                          ),
                        ),
                      ),
                      Text("Books",style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            //   GridListDemo(type: GridListDemoType.footer),
            myGrid()
          ],
        ),
      ]),
    );
  }
}

Widget _insertNotif() {
  return Badge(
    position: BadgePosition(bottom: 25, start: 25),
    badgeContent: Text(
      (2 > 8) ? "2" : "",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    badgeColor: Colors.red,
    child: IconButton(
      icon: Icon(
        Icons.notifications_none,
        color: Colors.black,
      ),
      onPressed: () {},
    ),
  );
}

Widget myGrid() {
  bool loved = false;

  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    // inside the <> you enter the type of your stream
    stream: FirebaseFirestore.instance.collection("Inserat").snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return GridView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                  onTap: () {
                    print(snapshot.data!.docs[index].id.toString()+'***************************************************************');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profile(
                              id_user: snapshot.data!.docs[index]
                                  .get('id_user')
                                  .toString())),
                    );
                  },
                  child: new GridTile(
                    footer: Material(
                      color: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(4)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: MyGridTile(name: snapshot.data!.docs[index].get('name'),id_inserat: snapshot.data!.docs[index].id.toString(),)
                    ),
                    child: FittedBox(
                      // child: Image.network(
                      //   snapshot.data!.docs[index].get('photo'),
                      // ),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data!.docs[index].get('photo'),

                        //  key: UniqueKey(),
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
