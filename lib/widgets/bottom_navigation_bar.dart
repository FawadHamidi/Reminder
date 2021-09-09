import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/screens/favorite_screen.dart';
import 'package:reminder/screens/home_screen.dart';
import 'package:reminder/screens/notification_screen.dart';
import 'package:reminder/services/provider.dart';
import 'package:reminder/widgets/loading.dart';
import 'drawer.dart';

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 1;
  int i;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<dynamic> pages = [
    Favorites(),
    MyHomePage(),
    NotificationScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final random = new Random();
    i = random.nextInt(80);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.loadWallpapers(),
      builder: (context, snap) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: snap.data != null && provider.wallpaperList != []
              ? BoxDecoration(
                  image: DecorationImage(
                  image:
                      NetworkImage("${provider.wallpaperList[i].src.portrait}"),
                  fit: BoxFit.cover,
                ))
              : BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage("assets/background.jpg"),
                  fit: BoxFit.cover,
                )),
          child: Scaffold(
            key: _scaffoldkey,
            drawer: MyDrawer(),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                pages[_selectedIndex],
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      print("fuck");
                      _scaffoldkey.currentState.openDrawer();
                    },
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                // color: Colors.white,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 1)
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(18),
              child: BottomNavigationBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    activeIcon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.format_quote_outlined),
                    activeIcon: Icon(Icons.format_quote_sharp),
                    label: 'Quotes',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_active_outlined),
                    activeIcon: Icon(Icons.notifications_active),
                    label: 'Notification',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.redAccent,
                onTap: _onItemTapped,
              ),
            ),
          ),
        );
        //: Center(child: MyLoading()
        //   Image.asset(
        //   'assets/logo.png',
        //   scale: 2,
        // )
        //  );
      },
    );
  }
}
