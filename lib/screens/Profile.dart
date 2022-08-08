import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../model/User.dart';
// import 'package:giget/screens/try.dart';

//import 'package:carousel_pro/carousel_pro.dart';

// import '../material_demo_types.dart';
// import '../model/User.dart';
// import 'Grid.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final current_user = FirebaseAuth.instance.currentUser!;
  int items_nbr=0;

   List<String> list_carousel =[];

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
        FirebaseFirestore.instance.collection("Users").doc(current_user.uid);
    final snapshot = await docUuser.get();

    if (snapshot.exists) {
      return User_Model.fromJson(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder<User_Model?>(
          future: readUser(),
          builder: (cotext, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data;
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

        myGrid(),
        showButton(),

        /////////////////
      ],
    );
  }

/////////////////////////////////////////////////////////////////////////////////
  Widget buildUser1(User_Model usr) {
    return //Text(snapshot[0]['name']),
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //    NavBar(),
        Stack(
          //  alignment: const Alignment(-1,1),
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: carousel(),
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
                    CircleAvatar(
                      backgroundImage: NetworkImage(usr.photo),
                      radius: 35,
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
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                          const Text(
                            'Berlin',
                            style: TextStyle(
                              fontSize: 10,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white,
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
              const Text(
                "Vinted cabinet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(txt),
              const SizedBox(
                height: 15,
              ),
              Text(
                usr.name + ' is looking for',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                ]),
              ),

              //   GridListDemo(type: GridListDemoType.footer),
              const SizedBox(
                height: 15,
              ),
              Text(
                "${usr.name} closet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );

    //  GridListDemo(type: GridListDemoType.footer),


  }

  Widget showButton(){

    return
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        //decoration: BoxDecoration(),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 40,
            width: 140,
            child: TextButton(
                child:
                    Text("Chat".toUpperCase(), style: TextStyle(fontSize: 14)),
                style: ButtonStyle(

                    // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff80E07E)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Color(0xff80E07E))))),
                onPressed: () {
                  print("sami al hamawi");
                }),
          ),
          SizedBox(width: 10),
          SizedBox(
            height: 40,
            width: 140,
            child: ElevatedButton(
                child:
                    Text("Swap".toUpperCase(), style: TextStyle(fontSize: 14)),
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
                  print("kebsssa kabba kaffee");
                }),
          )
        ]),
      )


      ;

  }
  Widget myGrid() {
    return  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        // inside the <> you enter the type of your stream
        stream: FirebaseFirestore.instance
            .collection("Inserat")
            .where('id_user', isEqualTo: current_user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            items_nbr=snapshot.data!.docs.length;
            return GridView.builder(
              shrinkWrap : true,
              physics: ScrollPhysics(),

              itemCount:snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:  2 ),
              itemBuilder: (BuildContext context, int index) {

               list_carousel.add(snapshot.data!.docs[index].get('photo').toString());


               return new Card(
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child:GestureDetector(

                      onTap: (){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snapshot.data!.docs[index].get('name').toString())));

                      },
                      child: new GridTile(
                          footer: Material(
                            color: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: GridTileBar(
                              backgroundColor: Colors.black26,
                              title:Text(snapshot.data!.docs[index].get('name')),

                              //  subtitle:Text("tiri berk"),
                            ),
                          ),
                          child:  FittedBox(
                             child: Image.network(snapshot.data!.docs[index].get('photo')),
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
      )
    ;
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
                  child: FittedBox(
                    child:Image.network(i),
                    fit: BoxFit.fill,
                  ));
            },
          ),
        );
      }).toList(),
    );
  }

}
