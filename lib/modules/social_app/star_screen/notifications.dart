import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../shared/componants/componant.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.start);
  final Widget start;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        Timer(Duration(seconds: 10), () {
          navigatAndFinsh(context, this.start);
        });
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          body: Column(
            children: [
              Container(
                color: Color.fromARGB(
                    255, 12, 83, 95), //Color.fromARGB(255, 26, 56, 104),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 100, bottom: 20, left: 15, right: 15),
                  child: Container(
                    //AssetImage('android/assets/images/lion.svg')

                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: Color.fromARGB(255, 24, 134, 153),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 350,

                    child: Center(
                        child: SvgPicture.asset(
                      'android/assets/images/lion.svg',
                      color: Color.fromARGB(255, 219, 227, 241),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 12, 83, 95),
                  child: Center(child: CircularProgressIndicator(color:Color.fromARGB(255, 24, 134, 153), )),
                ),
              )
            ],
          ),
        );
      },
    );
  }

/*

//print('Message data:${message.notification?.title}');
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  alert: true, // Required to display a heads up notification
  badge: true,
  sound: true,
);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  // If `onMessage` is triggered with a notification, construct our own
  // local notification to show to users using the created channel.
  
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
           channelDescription:  channel.description,
            icon: android.smallIcon,
            // other properties...
          ),
        ));
  }
});
*/
  /*
                 //await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// Firebase local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  //  print('message contained a notification :${message.notification}');

              FirebaseMessaging.onMessageOpenedApp
                  .listen((RemoteMessage message) {
                print('A new messageopen app event was published');
                RemoteNotification? notification = message.notification;
                AndroidNotification? android = message.notification?.android;
                if (notification != null && android != null) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text("${notification.title}"),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text("${notification.body}")],
                            ),
                          ),
                        );
                      });
                }
              });*/
  /* const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

// flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// firebase background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up :  ${message.messageId}');
*/
}
