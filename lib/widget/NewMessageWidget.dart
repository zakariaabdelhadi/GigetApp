import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lastgiget/screens/Explore.dart';
import 'package:lastgiget/screens/Profile.dart';

import '../api/GradientApi.dart';
import '../api/firebase_api.dart';

class NewMessageWidget extends StatefulWidget {
  final String idUser;

  const NewMessageWidget({
    required this.idUser,
    Key? key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();

    await FirebaseApi.uploadMessage(widget.idUser, message);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 45,
              width: 60,
              child: ElevatedButton(
                  child: Text("Swap".toUpperCase(), style: TextStyle(fontSize: 9)),
                  style: ButtonStyle(

                    //     padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff80E07E)),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff333333)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(6.0),
                              side: BorderSide(color: Color(0xff80E07E))))),
                  onPressed: () {

                    // Profile show=new Profile(id_user: '');
                   showOverlay(context);
                  // showOverlay(context);
                  }),
            ),
            SizedBox(width: 5,),
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  labelText: 'Type your message',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding:5,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            SizedBox(width: 5),
            Container(
              child: GestureDetector(
                onTap: () {
                  message.trim().isEmpty ? null : sendMessage();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff333333),
                  // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(6),
                      //gradient: LinearGradient(colors:[Color(0xff80E07E),Color(0xff00F0FF)],begin: Alignment.centerLeft,end: Alignment.centerRight),

                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    // child: RadiantGradientMask(
                    //   child:
                      child:Icon(
                        Icons.send,
                       color: Color(0xffffffff),
                      ),

                  //  ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

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
                getGridById(FirebaseAuth.instance!.currentUser!.uid!),
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
  Widget getGridById(String id) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      // inside the <> you enter the type of your stream
      stream: FirebaseFirestore.instance
          .collection("Inserat")
          .where('id_user', isEqualTo: id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data!.docs.length== 0){
            return  Center(
              child: Column(
                children: [
                  SizedBox(height: 90,),
                  Column(
                    children: [
                      Text('Your closet is empty',style: TextStyle(color: Colors.white,fontSize: 16),),
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white60,
                        child: SizedBox(height: 60,width: 60,child:
                        Image.asset('assets/images/sorry.png'),),
                      ),
                    ],
                  ),
                  //  Icon(Icons.)

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

}
