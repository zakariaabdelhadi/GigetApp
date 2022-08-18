import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String photo;

  const ProfileHeaderWidget({
    required this.name,
    required this.photo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
        height: 180,
        padding: EdgeInsets.all(8).copyWith(left: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 25,
                    child: BackButton(color: Colors.black)),

                // Container(
                // height: 50,
                // width: 50,
                // //  color: Color(0xff00F0FF),
                // decoration: BoxDecoration(
                // shape: BoxShape.circle,
                //
                //
                //
                // image:  DecorationImage(
                // fit: BoxFit.fill,
                // image: NetworkImage(user.urlAvatar),
                // ),
                // ),
                //
                //
                // ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 30,),
                      CircleAvatar(
                        radius: 35,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(imageUrl: photo)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 24,
                          //fontFamily: 'cookie',
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),

                    ],
                  ),
                ),


                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // buildIcon(
                    //   Icons.call,
                    // ),
                    SizedBox(width: 18),
                    // buildIcon(Icons.videocam),
                  ],
                ),
              ],
            )
          ],
        ),
      );

  Widget buildIcon(IconData icon) => Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black12,
        ),
        child: Icon(icon, size: 25, color: Colors.black),
      );
}
