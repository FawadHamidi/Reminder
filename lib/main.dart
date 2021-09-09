import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/screens/home_screen.dart';
import 'package:reminder/services/database_helper.dart';
import 'package:reminder/services/notification_manager.dart';
import 'package:reminder/services/provider.dart';
import 'package:reminder/services/service_locator.dart';
import 'package:reminder/widgets/bottom_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await locator<DatabaseHelper>().database;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isConnected = false;
  StreamSubscription sub;
  // final GlobalKey<NavigatorState> navigatorKey =
  //     GlobalKey(debugLabel: "Main Navigator");

  @override
  void initState() {
    // LocalNotifyManager manager = LocalNotifyManager.init();
    sub = Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        isConnected = (event != ConnectivityResult.none);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApiProvider>(
          create: (context) => ApiProvider(),
        ),
        ChangeNotifierProvider<DatabaseHelper>(
          create: (context) => DatabaseHelper(),
        ),
      ],
      child: MaterialApp(
        // navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Reminder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isConnected == false
            ? Center(
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Icon(
                    Icons.wifi_off,
                    size: 30,
                  ),
                ),
              )
            : MainApp(),
      ),
    );
  }
}
