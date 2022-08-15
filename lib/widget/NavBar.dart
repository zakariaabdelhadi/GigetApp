import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lastgiget/screens/Splash.dart';

import '../screens/Explore.dart';
import '../screens/Expose.dart';
import '../screens/FavoriteScreen.dart';
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

                    child: SplashView.counter_notif != 0 ?Badge(
                      position: BadgePosition(bottom: 16, start: 27),
                        badgeContent: Text(
                           SplashView.counter_notif.toString(),
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        badgeColor: Colors.red,
                      padding: EdgeInsets.all(8),
                      child: IconButton(
                        icon: Icon(
                          Icons.chat,
                          color: currentTab == 1 ? Color(0xFF00F0FF) : Colors.black,
                        ), onPressed: () {
                          setState(() {
                            SplashView.counter_notif=0;

                          });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const ChatsPage()),
                        );
                      },
                      ),
                    ):IconButton(
                      icon: Icon(
                        Icons.chat,
                        color: currentTab == 1 ? Color(0xFF00F0FF) : Colors.black,
                      ), onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const ChatsPage()),
                      );
                    },
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
                      setState(() {
                        currectScreen = FavoriteScreen();

                        currentTab = 2;
                      });
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
                        currectScreen = Expose();
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
