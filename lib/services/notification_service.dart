import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService{

  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }
  static Future init({bool initScheduled = false}) async {
    final android =  AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

static final FlutterLocalNotificationsPlugin _notificationsPlugin =
FlutterLocalNotificationsPlugin();

static void initialize() {
  // initializationSettings  for Android
  const InitializationSettings initializationSettings =
  InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  );

  _notificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? id) async {
      print("onSelectNotification");
      if (id!.isNotEmpty) {
        print("Router Value1234 $id");

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => DemoScreen(
        //       id: id,
        //     ),
        //   ),
        // );


      }
    },
  );
}



static void createanddisplaynotification(RemoteMessage message) async {
try {
final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
const NotificationDetails notificationDetails = NotificationDetails(
android: AndroidNotificationDetails(
"alone",
"aloneChannel",
importance: Importance.max,
priority: Priority.high,
),
);

await _notificationsPlugin.show(
id,
message.notification!.title,
message.notification!.body,
notificationDetails,
payload: message.data['_id'],
);
} on Exception catch (e) {
print(e);
}
}
static void instantNotification({required String title, required String body,}) async {
try {
final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
const NotificationDetails notificationDetails = NotificationDetails(
android: AndroidNotificationDetails(
"alone",
"aloneChannel",
importance: Importance.max,
priority: Priority.high,
),
);

await _notificationsPlugin.show(
id,
title,
body,
notificationDetails,
);
} on Exception catch (e) {
print(e);
}
}
  static void showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
}
