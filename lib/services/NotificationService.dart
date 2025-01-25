import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/CarModel.dart';

class NotificationService {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
  static DarwinInitializationSettings initializationSettingsDarwin = const DarwinInitializationSettings(
    requestAlertPermission: true,
  );
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

  Future<void> init() async {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> scheduleReturnReminder(DateTime endDate, CarModel car) async {
    print(endDate);
    //Schedule a reminder for returning the car an hour before the rental period ends
    //Reminder is scheduled one hour before the end of the rental
    final reminderDateTime = tz.TZDateTime.from(endDate.subtract(const Duration(hours: 1)), tz.local);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Auto terug brengen',
        'Uw boeking van de ${car.brand} ${car.model} verloopt over een uur. Breng de auto svp binnen een uur terug op de aangewezen parkeerplaats.',
        reminderDateTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'status_change',
              'Boekingstatus',
              channelDescription: 'Veranderingen in de status van de boeking',
          )
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    );
  }

}