import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lastgiget/screens/Splash.dart';

import '../api/GradientApi.dart';
import '../screens/Explore.dart';
import '../screens/Expose.dart';
import '../screens/FavoriteScreen.dart';
import '../screens/Profile.dart';
import '../screens/add_inserat.dart';
import '../screens/chatsPage.dart';
import 'package:swipe_to/swipe_to.dart';

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
  void update(int count) {
    setState(() => currentTab = count);

  }

  final PageStorageBucket bucket = PageStorageBucket();
  late Widget currectScreen ;
@override
  void initState() {
    super.initState();
   currectScreen = Explore(update: update,); ////// Explore

}

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
          child: RadiantGradientMask(child: Icon(Icons.add, color: Colors.white)),
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
                        currectScreen = Explore(update: update,);

                        currentTab = 0;
                      });
                    },
                    child:  currentTab != 0 ? Icon(
                      Icons.home,
                      color:   Colors.black,
                    ):RadiantGradientMask(
                      child: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                    ),


                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currectScreen = ChatsPage(update: update,);
                       currentTab = 1;
                      });
                    },

                    child: SplashView.counter_notif != 0
                        ? Badge(
                            position: BadgePosition(bottom: 20, start: 30),
                            badgeContent: Text(
                              SplashView.counter_notif.toString(),
                              style: TextStyle(
                                fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  ),
                            ),
                            badgeColor: Colors.red,
                            padding: EdgeInsets.all(8),
                            child:
                            IconButton(
                              icon: Icon(
                                Icons.chat,
                                color: currentTab == 1
                                    ? Color(0xFF00F0FF)
                                    : Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  SplashView.counter_notif = 0;
                                  currectScreen = ChatsPage(update:update,);
                                currentTab = 1;
                                });

                              },
                            ),
                          )
                        :currentTab == 1 ?

                    RadiantGradientMask(
                      child: Icon(
                              Icons.chat,
                              color: Colors.white,
                            ),
                    ):Icon(
                      Icons.chat,
                      color:  Colors.black,
                    ),
                    // onPressed: () {
                    //   // Navigator.push(
                    //   //   context,
                    //   //   MaterialPageRoute(
                    //   //       builder: (context) =>
                    //   //       const ChatsPage()),
                    //   // );
                    // },
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
                        currectScreen = FavoriteScreen(update: update,);

                   currentTab = 2;
                      });
                    },
                    child: currentTab== 2 ?
                    RadiantGradientMask(
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ):Icon(
                      Icons.favorite_border,
                      color:  Colors.black,
                    ),


                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currectScreen = Expose(update: update,);
                     currentTab = 3;
                        //    Navigator.pushReplacementNamed(context,"lib/screens/Profile.dart");
                      });
                    },
                    child:currentTab == 3 ?
                    RadiantGradientMask(
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                      ),
                    ):Icon(
                      Icons.account_circle_outlined,
                    color:  Colors.black,
                  ),

                    // Icon(
                    //   Icons.account_circle_outlined,
                    //   color: currentTab == 3 ? Color(0xFF00F0FF) : Colors.black,
                    // ),
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
