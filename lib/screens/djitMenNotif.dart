import 'package:flutter/material.dart';

class DjitNotif extends StatelessWidget {

  final String Payload;
  const DjitNotif({Key? key,required String this.Payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Djit men Notif click"),
      ),
    );
  }
}
