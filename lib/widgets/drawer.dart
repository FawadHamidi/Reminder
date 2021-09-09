import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Image.asset('assets/logo.png'),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 5,
                  color: Colors.grey.withOpacity(0.5),
                  indent: 60,
                  endIndent: 60,
                ),
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: _instagramURL,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/instagram.png',
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Instagram',
                            style: TextStyle(
                                fontFamily: 'Frutiger',
                                fontWeight: FontWeight.w300,
                                fontSize: 16))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: _facebookURL,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/facebook.png',
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text('Facebook',
                            style: TextStyle(
                                fontFamily: 'Frutiger',
                                fontWeight: FontWeight.w300,
                                fontSize: 16))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Developed by Artify Team \n Version: 1.0.0',
                      style: TextStyle(
                          fontFamily: 'Frutiger',
                          color: Colors.grey.withOpacity(0.6),
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: _pexelURL,
                child: Text.rich(
                  TextSpan(
                    text: 'Photos by ',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Pexels',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.grey)),
                      // can add more TextSpans here...
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  _instagramURL() async {
    const url = 'https://www.instagram.com/re___minder/';

    await launch(url);
  }

  _facebookURL() async {
    const url = 'https://www.facebook.com/REMINDE';

    await launch(url);
  }

  _pexelURL() async {
    const url = 'https://www.pexels.com/';

    await launch(url);
  }
}
