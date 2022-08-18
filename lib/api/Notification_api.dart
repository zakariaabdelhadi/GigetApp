

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lastgiget/utils.dart';

import 'package:flutter/material.dart';

import '../screens/chatsPage.dart';

class NotificationService {

  get flutterLocalNotificationsPlugin1 => FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        flutterLocalNotificationsPlugin1;

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");
    //  final IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // final MacOSInitializationSettings initializationSettingsMacOS =
    // MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
      // macOS: initializationSettingsMacOS
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    ////////////////////
  }

  void selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }

    // Navigator.push(
    //     context,
    //     MaterialPageRoute<void>(builder: (context) => ChatsPage()),
    //   );
  }

  void Display(String title, String body, String pictureLink,String iconLink) async {
    final picturePath = await Utils.downloadFile(pictureLink,'picture');
    final iconPath = await  Utils.downloadFile(iconLink,'icon');

    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('channel id', 'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: BigPictureStyleInformation(
            FilePathAndroidBitmap(
                picturePath),
            largeIcon: FilePathAndroidBitmap(
                iconPath)),
        ticker: 'ticker');

    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin1
        .show(0, title, body, platformChannelSpecifics, payload: 'item x');
  }



}

//
// class NotificationService {
//
//
// }


