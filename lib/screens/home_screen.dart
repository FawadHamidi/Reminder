import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/screens/favorite_screen.dart';
import 'package:reminder/services/provider.dart';
import 'package:reminder/widgets/custom_icon.dart';
import 'package:reminder/widgets/loading.dart';
import 'package:share/share.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  // bool isConnected = false;
  // StreamSubscription sub;
  // int previousitem;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => Favorites()));
        // } else if (index == 1) {
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (ctx) => MyHomePage()));
      } else if (index == 3) {
        print('hi');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // sub = Connectivity().onConnectivityChanged.listen((event) {
    //   setState(() {
    //     isConnected = (event != ConnectivityResult.none);
    //   });
    // });
  }

  // @override
  // void dispose() {
  //   sub.cancel();
  //   super.dispose();
  // }

  IconData icon;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);

    // print(provider.wallpaperList[0].id);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder(
              future: provider.loadQuotes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    provider.quoteList.length != null)
                  return SafeArea(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   height: 35,
                      // ),

                      CarouselSlider.builder(
                        itemCount: provider.quoteList.length,
                        itemBuilder: (context, index, int) {
                          // print('kamraaaaaaaaaaaaaan $index');
                          final random = new Random();
                          var i = random.nextInt(provider.quoteList.length);
                          // print(i);
                          // if (previousitem == null)
                          //   previousitem = i;
                          // else {
                          //   if (previousitem > index) {
                          //     print("left");
                          //   } else {
                          //     print("right");
                          //   }
                          // }

                          return Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 5,
                                              spreadRadius: 1),
                                        ],
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.2,
                                      child: Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Icon(Icons.format_quote),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30),
                                              child: Text(
                                                provider.quoteList[i].text,
                                                style: TextStyle(
                                                  fontFamily: 'Frutiger',
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .horizontal_rule_outlined,
                                                  color: Colors.black54,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  provider.quoteList[i]
                                                              .author ==
                                                          'null'
                                                      ? 'Unknown'
                                                      : provider
                                                          .quoteList[i].author,
                                                  style: TextStyle(
                                                    fontFamily: 'Frutiger',
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons
                                                      .horizontal_rule_outlined,
                                                  color: Colors.black54,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                    icon: Icon(Icons.ios_share),
                                                    onPressed: () {
                                                      Share.share(
                                                          '${provider.quoteList[i].text} \n - ${provider.quoteList[i].author} -' +
                                                              '\n\n' +
                                                              '#Reminder');
                                                    }),
                                                CustomIcon(i),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: CircleAvatar(
                                          radius: 50,
                                          child: Image.asset('assets/logo.png'),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 6,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height / 1.5,
                          aspectRatio: 0.8,

                          enableInfiniteScroll: true,
                          autoPlay: false,
                          // autoPlayInterval: Duration(seconds: 5),
                          // autoPlayAnimationDuration:
                          //     Duration(milliseconds: 800),
                          pauseAutoPlayOnTouch: true,
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                        ),
                      ),
                    ],
                  ));
                return Center(child: MyLoading());
              }),
        ),
        provider.isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(),
      ],
    );
  }
}
