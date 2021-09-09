import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotifyManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initSetting;
  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();
  LocalNotifyManager.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  initializePlatform() {
    var initSettingAndroid = AndroidInitializationSettings('reminder');
    var initSettingIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notification = ReceiveNotification(
              id: id, title: title, body: body, payload: payload);
          didReceiveLocalNotificationSubject.add(notification);
        });
    initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIOS);

    flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: onSelect);
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification(String title, String body, int index) async {
    final timeZone = tz.initializeTimeZones();
    var detroit = tz.getLocation('America/Detroit');
    var location = tz.setLocalLocation(detroit);
    var dateTime = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 0, 0);
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'Notification 1',
      'CHANNEL_DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      // fullScreenIntent: true,
      // ongoing: true,
      styleInformation: BigTextStyleInformation(body),
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    var iosChannel = IOSNotificationDetails();

    try {
      var platformChannel =
          NotificationDetails(android: androidChannel, iOS: iosChannel);
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.from(dateTime, detroit),
        platformChannel,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: '$index',
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> showSecondNotification(
      String title, String body, int index) async {
    final timeZone = tz.initializeTimeZones();
    var detroit = tz.getLocation('America/Detroit');
    var location = tz.setLocalLocation(detroit);
    var dateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 15, 0, 0);

    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID 2',
      'Notification 2',
      'CHANNEL_DESCRIPTION 2',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      // fullScreenIntent: true,
      styleInformation: BigTextStyleInformation(body),
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    var iosChannel = IOSNotificationDetails();
    try {
      var platformChannel =
          NotificationDetails(android: androidChannel, iOS: iosChannel);
      await flutterLocalNotificationsPlugin.zonedSchedule(1, title, body,
          tz.TZDateTime.from(dateTime, detroit), platformChannel,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
          payload: '$index');
    } catch (e) {
      print(e);
    }
  }

  Future<void> showThirdNotification(
      String title, String body, int index) async {
    final timeZone = tz.initializeTimeZones();
    var detroit = tz.getLocation('America/Detroit');
    var location = tz.setLocalLocation(detroit);
    var dateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 21, 0, 0);

    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID 3',
      'Notification 3',
      'CHANNEL_DESCRIPTION 3',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      // fullScreenIntent: true,
      styleInformation: BigTextStyleInformation(body),
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    var iosChannel = IOSNotificationDetails();
    try {
      var platformChannel =
          NotificationDetails(android: androidChannel, iOS: iosChannel);
      await flutterLocalNotificationsPlugin.zonedSchedule(2, title, body,
          tz.TZDateTime.from(dateTime, detroit), platformChannel,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
          payload: '$index');
    } catch (e) {
      print(e);
    }
  }

  Future<void> cancelNotifications() async {
    try {
      await flutterLocalNotificationsPlugin.cancelAll();
    } catch (e) {
      print(e);
    }
  }

  Future onSelect(String payload) {
    print("notifiesdas selected");
    return Future.value(true);
  }
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceiveNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceiveNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}
