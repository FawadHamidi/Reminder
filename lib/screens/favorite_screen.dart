import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/screens/home_screen.dart';
import 'package:reminder/services/database_helper.dart';
import 'package:reminder/services/provider.dart';
import 'package:reminder/services/service_locator.dart';
import 'package:reminder/utilis/constants.dart';
import 'package:reminder/widgets/delete_all_queries.dart';
import 'package:reminder/widgets/delete_icon.dart';
import 'package:share/share.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 1),
      () => _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      ),
    );

    var provider = Provider.of<ApiProvider>(context, listen: false);
    var providerDB = Provider.of<DatabaseHelper>(context, listen: false);
    print('lllll');
    provider.loadQueries();
    return Consumer<ApiProvider>(
      builder: (context, provider, child) {
        print('builder');
        return provider?.queryList?.isEmpty ?? true
            ? Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No Favorites!',
                            style: TextStyle(
                              fontFamily: 'Frutiger',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.transparent,
                floatingActionButton: DeleteAll(),
                body: Container(
                  margin: EdgeInsets.only(top: 60),
                  child: ListView.builder(
                    controller: _controller,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                spreadRadius: 1),
                          ],
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        height: MediaQuery.of(context).size.height / 2,
                        width: 200,
                        child: Card(
                          elevation: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Icon(Icons.format_quote_rounded),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(provider.queryList[index].text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Frutiger',
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.horizontal_rule_outlined,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      provider.queryList[index].author == 'null'
                                          ? 'Unknown'
                                          : provider.queryList[index].author,
                                      style: TextStyle(
                                        fontFamily: 'Frutiger',
                                        fontSize: 14,
                                        color: Colors.black54,
                                      )),
                                  Icon(
                                    Icons.horizontal_rule_outlined,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.ios_share),
                                      onPressed: () {
                                        Share.share(
                                            '${provider.queryList[index].text} \n - ${provider.queryList[index].author} -' +
                                                '\n\n' +
                                                '#Reminder');
                                      }),
                                  DeleteQuote(
                                    index,
                                    onDelete: (int i) {
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: provider.queryList.length,
                  ),
                ),
              );
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
