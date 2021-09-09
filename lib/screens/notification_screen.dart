import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/screens/on_click_notification_screen.dart';
import 'package:reminder/services/notification_manager.dart';
import 'package:reminder/services/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String title,
      author,
      secondTitle,
      secondAuthor,
      thirdTitle,
      thirdAuthor,
      payload;
  int index;
  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  void toggleSwitch(bool value) async {
    if (isSwitched == false) {
      setState(() {
        localNotifyManager.showNotification(author, title, index);
        localNotifyManager.showSecondNotification(
            secondAuthor, secondTitle, index + 1);
        localNotifyManager.showThirdNotification(
            thirdAuthor, thirdTitle, index + 2);
        isSwitched = true;
        textValue = 'Switch Button is ON';
        saveStateUi();
      });

      print('Switch Button is ON');
    } else {
      setState(() {
        localNotifyManager.cancelNotifications();
        textValue = 'Switch Button is OFF';
        isSwitched = false;
        saveStateUi();
      });

      print('Switch Button is OFF');
    }
  }

  saveStateUi() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('switch', isSwitched);
  }

  Future<bool> getStateUi() async {
    final preferences = await SharedPreferences.getInstance();
    isSwitched = preferences.getBool('switch') ?? false;
    return isSwitched;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);

    // getStateUi();
    print(isSwitched);
    //
    Timer(Duration(seconds: 3), () => print('after 3 min $isSwitched'));
  }

  onNotificationReceive(ReceiveNotification notification) {
    print('${notification.payload}');
  }

  onNotificationClick(String payload) {
    print('${payload}____&&&&&&&&&&&&&&&&&&&&&&&');
    print(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewNotificationScreen(
                  i: int.parse(payload),
                )));
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    var provider = Provider.of<ApiProvider>(context, listen: false);

    final random = new Random();
    index = random.nextInt(provider.quoteList.length);
    title = provider.quoteList[index].text;
    secondTitle = provider.quoteList[index + 1].text;
    secondAuthor = provider.quoteList[index + 1].author;
    thirdTitle = provider.quoteList[index + 2].text;
    thirdAuthor = provider.quoteList[index + 2].author;

    author = provider.quoteList[index].author;
    return Container(
      height: 60,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15, left: 10, right: 10),
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1),
          ],
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Notifications',
                    style: TextStyle(
                      fontFamily: 'Frutiger',
                      fontSize: 16,
                      color: Colors.black,
                    )),
                Text('Three times per day',
                    style: TextStyle(
                      fontFamily: 'Frutiger',
                      fontSize: 10,
                      color: Colors.black.withOpacity(0.3),
                    )),
              ]),
          FutureBuilder<bool>(
              future: getStateUi(),
              builder: (context, snap) {
                return Switch(
                  onChanged: toggleSwitch,
                  value: snap.data,
                  activeColor: Colors.green,
                  activeTrackColor: Colors.greenAccent,
                  inactiveThumbColor: Colors.grey.shade300,
                  inactiveTrackColor: Colors.grey.shade200,
                );
              }),
        ],
      ),
    );
  }
}
