
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  const DisplayImage({Key? key,required this.url}) : super(key: key);
final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            BackButton(
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
            SizedBox(
              width: 400,
              height: 500,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                 // height: double.infinity,
                  //width: double.infinity,
                  //alignment: Alignment.center,
                ) ,
              ),
            ),
          ],
        ),
      )
    );
  }
}
