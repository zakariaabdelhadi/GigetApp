import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lastgiget/screens/FulllImage.dart';
import 'package:lastgiget/screens/Profile.dart';
import 'package:lastgiget/widget/MyGridTile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lastgiget/widget/NavBar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:swipe_to/swipe_to.dart';

import '../api/GradientApi.dart';
import 'chatsPage.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key, required this.update}) : super(key: key);
  final ValueChanged<int> update;

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
              child: GradientText(
                "GiGet",
                style: TextStyle(
                  fontFamily: 'cookie',
                  fontSize: 50,
                  //fontWeight: FontWeight.bold,
                ),
                colors: [
                  Color(0xff5FA95E),
                  Color(0xFF00F0FF),
                ],
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
          body: Explore_body(update: widget.update)
          //body:  GridListDemo(type: GridListDemoType.footer),
          ),
    );
  }
}

class Explore_body extends StatefulWidget {
  const Explore_body({Key? key, required this.update}) : super(key: key);
  final ValueChanged<int> update;

  @override
  State<Explore_body> createState() => _Explore_bodyState();
}

class _Explore_bodyState extends State<Explore_body> {
  bool games = false;
  bool electronics = false;
  bool books = false;
  bool textile = false;

  String activPage = 'all';
  bool loved = false;
  TextEditingController searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
        } else if (details.primaryVelocity! < 0) {
          widget.update(1);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatsPage(
                      update: widget.update,
                    )),
          );
        }
      },
      child: Scaffold(
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
                          controller: searchControl,
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
                    RadiantGradientMask(
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Color(0xFF00F0FF),
                        ),
                        onPressed: () {
                          if(searchControl.text != ''){
                            setState(() {
                              games = false;
                              electronics = false;
                              books = false;
                              textile = false;
                              activPage = 'search';
                            });
                          //  searchControl.clear();


                          }

                        },
                      ),
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
                                color: games ? Color(0xFF00F0FF) : Colors.black,
                                // size: 24,
                              ),
                              tooltip: 'Increase volume by 10',
                              onPressed: () {
                                setState(() {
                                  games ? games = false : games = true;
                                  if (games == true) {
                                    activPage = 'Games';
                                    textile = false;
                                    electronics = false;
                                    books = false;
                                  }
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           const getCategory(category: "Games")),
                                // );
                              },
                            ),
                          ),
                        ),
                        Text(
                          "Games",
                          style: TextStyle(fontSize: 12),
                        ),
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
                                color: electronics
                                    ? Color(0xFF00F0FF)
                                    : Colors.black,
                                size: 40,
                              ),
                              onPressed: () {
                                setState(() {
                                  electronics
                                      ? electronics = false
                                      : electronics = true;
                                  if (electronics == true) {
                                    activPage = 'Electronics';
                                    textile = false;
                                    games = false;
                                    books = false;
                                  }
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const getCategory(
                                //           category: "Electronics")),
                                // );
                              },
                            ),
                          ),
                        ),
                        Text("Electronics", style: TextStyle(fontSize: 12)),
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
                                color:
                                    textile ? Color(0xFF00F0FF) : Colors.black,
                                size: 40,
                              ),
                              onPressed: () {
                                setState(() {
                                  textile ? textile = false : textile = true;
                                  if (textile == true) {
                                    activPage = 'Textile';

                                    electronics = false;
                                    games = false;
                                    books = false;
                                  }
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           const getCategory(category: "Textile")),
                                // );
                              },
                            ),
                          ),
                        ),
                        Text("Textile", style: TextStyle(fontSize: 12)),
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
                                color: books ? Color(0xFF00F0FF) : Colors.black,
                                size: 40,
                              ),
                              onPressed: () {
                                setState(() {
                                  books ? books = false : books = true;
                                  if (books == true) {
                                    activPage = 'Books';

                                    electronics = false;
                                    games = false;
                                    textile = false;
                                  }
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           const getCategory(category: "Books")),
                                // );
                              },
                            ),
                          ),
                        ),
                        Text("Books", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              //   GridListDemo(type: GridListDemoType.footer),

              if (games == true ||
                  electronics == true ||
                  books == true ||
                  textile == true)
                myGridCategory(),

              if (games == false &&
                  electronics == false &&
                  books == false &&
                  textile == false &&
                  activPage != 'search')
                myGrid(),
              if (activPage == 'search') SearchGrid(searchControl.text),
            ],
          ),
        ]),
      ),
    );
  }

  Widget myGridCategory() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      // inside the <> you enter the type of your stream
      stream: FirebaseFirestore.instance
          .collection("Inserat")
          .where('category', isEqualTo: activPage)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.length == 0) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(textAlign: TextAlign.center,
                      ' sorry at the moment there is no object in the Category ${activPage}. Come and check later',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: 60,width: 60,child: 
                    Image.asset('assets/images/sorry.png'),),
                  SizedBox(
                    height: 30,
                  ),
                  //  Icon(Icons.)
                  GestureDetector(
                    child: Text(textAlign: TextAlign.center,'click to show all articles',style: TextStyle(color: Colors.blueAccent,fontSize: 12),),
                    onTap: () {
                      setState(() {
                        games = false;
                        electronics = false;
                        books = false;
                        textile = false;
                        activPage = 'all';
                      });
                    },
                  )
                ],
              ),
            );
          }
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
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(4)),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: MyGridTile(
                            photo: snapshot.data!.docs[index].get('photo'),
                            name: snapshot.data!.docs[index].get('name'),
                            id_inserat:
                                snapshot.data!.docs[index].id.toString(),
                          )),
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

  Widget SearchGrid(String item) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      // inside the <> you enter the type of your stream
      stream: FirebaseFirestore.instance
          .collection("Inserat")
          .where('name', isEqualTo: item)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.length == 0) {
            print(snapshot.data!.docs.length.toString()+'------------');
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                  ),

                  Text(
                    'sorry no articles currently matching your search',
                    textAlign: TextAlign.center,),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: 60, width: 60, child:
                  Image.asset('assets/images/sorry.png'),),
                  SizedBox(
                    height: 30,
                  ),
                  //  Icon(Icons.)
                  GestureDetector(
                    child: Text(
                      'click to show all articles', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue),),
                    onTap: () {
                      setState(() {
                        activPage = 'all';
                      });
                    },
                  )
                ],
              ),
            );
          }
            print('dkhel comme memme ------------------');
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
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(4)),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: MyGridTile(
                              photo: snapshot.data!.docs[index].get('photo'),
                              name: snapshot.data!.docs[index].get('name'),
                              id_inserat:
                                  snapshot.data!.docs[index].id.toString(),
                            )),
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
          print(
              'rahou hna ydour __________________________________________________-');
          return Center(
            child: Column(
              children: [
                Text('sorry keine Artikel zurzeit, die deiner Suche zutreffen'),
                SizedBox(
                  height: 30,
                ),
                //  Icon(Icons.)
                GestureDetector(
                  child: Text('Klicken Sie, um alle Artikel anzuzeigen'),
                  onTap: () {
                    setState(() {
                      activPage = 'all';
                    });
                  },
                )
              ],
            ),
          );
        }
      },
    );
  }
}

Widget _insertNotif() {
  return IconButton(
    icon: Icon(
      Icons.notifications_none,
      color: Colors.black,
    ),
    onPressed: () {},
  );

  //   Badge(
  //   position: BadgePosition(bottom: 25, start: 25),
  //   badgeContent: Text(
  //     (2 > 8) ? "2" : "",
  //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //   ),
  //   badgeColor: Colors.red,
  //   child: IconButton(
  //     icon: Icon(
  //       Icons.notifications_none,
  //       color: Colors.black,
  //     ),
  //     onPressed: () {},
  //   ),
  // );
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
                    if (snapshot.data!.docs[index].get('id_user').toString() !=
                        FirebaseAuth.instance.currentUser!.uid.toString()) {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                id_user: snapshot.data!.docs[index]
                                    .get('id_user')
                                    .toString())),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('This is your article')));

                    }
                  },
                  child: new GridTile(
                    footer: Material(
                        color: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(bottom: Radius.circular(4)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: MyGridTile(
                          photo: snapshot.data!.docs[index].get('photo'),
                          name: snapshot.data!.docs[index].get('name'),
                          id_inserat: snapshot.data!.docs[index].id.toString(),
                        )),
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
