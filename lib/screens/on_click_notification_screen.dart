import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/services/provider.dart';
import 'package:share/share.dart';

class ViewNotificationScreen extends StatelessWidget {
  final int i;

  ViewNotificationScreen({this.i});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    return Scaffold(
      body: Center(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 120,
            ),
            Image.asset(
              'assets/logo.png',
              scale: 4,
            ),
            Text(
              provider.quoteList[i].text,
              style: TextStyle(
                fontFamily: 'Frutiger',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            // SizedBox(
            //   height: 10,
            // ),
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
                  provider.quoteList[i].author,
                  style: TextStyle(
                    fontFamily: 'Frutiger',
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.horizontal_rule_outlined,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            IconButton(
                icon: Icon(Icons.ios_share),
                iconSize: 35,
                onPressed: () {
                  Share.share(
                      '${provider.quoteList[i].text} \n - ${provider.quoteList[i].author} -');
                }),
            Container(
              height: 120,
            ),
          ],
        ),
      )),
    );
  }
}
