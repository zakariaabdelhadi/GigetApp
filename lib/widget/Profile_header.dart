import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String photo;

  const ProfileHeaderWidget({
    required this.name,required this.photo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    height: 70,
    padding: EdgeInsets.all(8).copyWith(left: 0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(color: Colors.white),
            CircleAvatar(
              radius: 25,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(imageUrl: photo)),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  //fontFamily: 'cookie',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildIcon(Icons.call),
                SizedBox(width: 12),
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
      color: Colors.white54,
    ),
    child: Icon(icon, size: 25, color: Colors.white),
  );
}