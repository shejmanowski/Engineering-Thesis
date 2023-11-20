import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class SetSleepPage extends StatefulWidget {
  @override
  _SetSleepPageState createState() => _SetSleepPageState();
}

class _SetSleepPageState extends State<SetSleepPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late TextEditingController bedtimeController;
  late TextEditingController wakeupTimeController;
  late TimeOfDay bedtime;
  late TimeOfDay futureBedtime;
  late List<DateTime> bedtimeSchedule;
  @override
  void initState() {
    super.initState();
    bedtimeController = TextEditingController();
    wakeupTimeController = TextEditingController();
    bedtime = TimeOfDay.now();
    futureBedtime = TimeOfDay.now();
    bedtimeSchedule=List.empty();
        const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("logo_3");

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
      macOS: null,
      linux: null,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void showNotification() {
    if (bedtimeSchedule.isEmpty) {
      return;
    }

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "ScheduleNotification001",
      "Notify Me",
      importance: Importance.high,
    );
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: null,
      linux: null,
    );
    DateTime datetime = DateTime.now();
    //  flutterLocalNotificationsPlugin.show(
    //      01, "cos", "sa", notificationDetails);
    print("a");
    int i=1;
    tz.initializeTimeZones();
      final tz.TZDateTime scheduledAt = tz.TZDateTime.from(datetime.add(Duration(seconds: 5)), tz.local);    
      print(scheduledAt);
      print(tz.local);
      print("a");
      flutterLocalNotificationsPlugin.zonedSchedule(
        i, "Pora", "SPAC", scheduledAt, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      );
      i++;
    
    // for (DateTime element in bedtimeSchedule) {
    //   final tz.TZDateTime scheduledAt = tz.TZDateTime.from(element, tz.local);    
    //   print(scheduledAt);
    //   print(tz.local);
    //   print("a");
    //   flutterLocalNotificationsPlugin.zonedSchedule(
    //     i, "Pora", "SPAC", scheduledAt, notificationDetails,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime,
    //     androidAllowWhileIdle: true,
    //   );
    //   i++;
    // }
    
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Ustaw czas spania',
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      ),
      centerTitle: true,
      elevation: 0,
    ),
    body: Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), 
                color: Theme.of(context).colorScheme.primary,

  ),
              child: Column(
                children: [
                    ListTile(
              title: Text('Czas pójścia spać'),
              subtitle: Text('${bedtime.hour}:${bedtime.minute}'),
              onTap: () => _selectBedtime(context),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Docelowy czas pójścia spać'),
              subtitle: Text('${futureBedtime.hour}:${futureBedtime.minute}'),
              onTap: () => _selectWakeupTime(context),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
              onPressed: () => generateBedtimeSchedule(bedtime, futureBedtime),
              child: Text(
                'Ustaw przypomnienie o pójściu spać',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
              ]),
            ),
            
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: bedtimeSchedule.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Czas pójścia spać: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(bedtimeSchedule[index])}',
                      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
    backgroundColor: Theme.of(context).colorScheme.background,
  );
}

  Future<void> _selectBedtime(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: bedtime,
    );

    if (selectedTime != null && selectedTime != bedtime) {
      setState(() {
        bedtime = selectedTime;
      });
    }
  }

  Future<void> _selectWakeupTime(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: futureBedtime,
    );

    if (selectedTime != null && selectedTime != futureBedtime) {
      setState(() {
        futureBedtime = selectedTime;
      });
    }
  }
  void generateBedtimeSchedule(TimeOfDay currentBedtime, TimeOfDay targetBedtime) {
  int i =0;
  List<DateTime> bedtimeScheduletmp = [];

  bedtimeScheduletmp.add(convertTimeOfDayToDateTime(currentBedtime, i));
  while (currentBedtime != targetBedtime) {
      i++;
      currentBedtime = subtractTime(currentBedtime, 10);
      bedtimeScheduletmp.add(convertTimeOfDayToDateTime(currentBedtime, i));
  }
  
  setState(() {
    bedtimeSchedule =bedtimeScheduletmp;
  });
  showNotification();
}
DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay, int offset) {
  final now = DateTime.now().add(Duration(days: offset));
  return DateTime(
    now.year,
    now.month,
    now.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );
}
TimeOfDay subtractTime(TimeOfDay time, int minutesToSubtract) {
  int totalMinutes = time.hour * 60 + time.minute;
  totalMinutes -= minutesToSubtract;

  if (totalMinutes < 0) {
    totalMinutes += 24 * 60; 
  }

  int newHour = totalMinutes ~/ 60;
  int newMinute = totalMinutes % 60;

  return TimeOfDay(hour: newHour, minute: newMinute);
}
}