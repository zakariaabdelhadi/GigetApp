import 'package:flutter/material.dart';

import '../screens/Explore.dart';
import '../screens/Profile.dart';
import '../screens/add_inserat.dart';
import '../screens/chatsPage.dart';

/*
import '../data.dart';
import '../screens/Explore.dart';
import '../screens/Expose.dart';
import '../screens/Profile.dart';
import '../screens/add_inserat.dart';
import '../screens/chatsPage.dart';
*/

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currectScreen = Explore(); ////// Explore

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currectScreen,
      ),
      floatingActionButton: Transform.scale(
        scale: 0.9,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddInserat()),
            );
          },
          child: Icon(Icons.add, color: Color(0xFF00F0FF)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 2,
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currectScreen = Explore();
                        currentTab = 0;
                      });
                    },
                    child: Icon(
                      Icons.home,
                      color: currentTab == 0 ? Color(0xFF00F0FF) : Colors.black,
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currectScreen = ChatsPage();
                        currentTab = 1;
                      });
                    },
                    child: Icon(
                      Icons.chat,
                      color: currentTab == 1 ? Color(0xFF00F0FF) : Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      // setState(() {
                      //   currectScreen = Expose();
                      //
                      //   currentTab = 2;
                      // });
                    },
                    child: Icon(
                      Icons.favorite_border,
                      color: currentTab == 2 ? Color(0xFF00F0FF) : Colors.black,
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                     onPressed: () {
                      setState(() {
                        currectScreen = Profile();
                        currentTab = 3;
                        //    Navigator.pushReplacementNamed(context,"lib/screens/Profile.dart");
                      });
                    },
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: currentTab == 3 ? Color(0xFF00F0FF) : Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
