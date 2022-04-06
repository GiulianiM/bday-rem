import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'Compleanno', // title
  description: 'Nato oggi.',
  // description
  importance: Importance.max,
);
final FlutterLocalNotificationsPlugin flnp = FlutterLocalNotificationsPlugin();

void setupNotification() {
  firebaseMessagingDeviceToken();
  createAndroidNotificationChannel();
  handleAndroidForegroundNotification();
  handleIOSForegroundNotification();
}

Future<void> handleIOSForegroundNotification() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void handleAndroidForegroundNotification() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flnp.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
              // other properties...
            ),
          ));
    }
  });
}

Future<void> createAndroidNotificationChannel() async {
  await flnp
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

//For Apple & Web
//asking the user's permission.
Future<void> iosWebPermission() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  //On Android authorizationStatus will return authorized if the user has not
  // disabled notifications for the app via the operating systems settings.
  if (kDebugMode) {
    print('User granted permission: ${settings.authorizationStatus}');
  }
}

//print FCM device token
Future<void> firebaseMessagingDeviceToken() async {
  if (kDebugMode) {
    print("FCM TOKEN: ${await FirebaseMessaging.instance.getToken()}");
  }
}

//print the message received from FCM and print it on serial.
//it doesn't work if the app is in the foreground
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}
