import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class Login extends StatefulWidget{
  _Login createState()=>_Login();
}
int hours=0;
int minutes=0;
class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        body:GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: ()=>ClockTimeNotification(hours,minutes),
                  child:Text('Show Notification'),
                ),
                Padding(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged:(text){
                      setState((){
                        hours=int.parse(text);;
                        print(hours+minutes);
                        ClockTimeNotification(hours,minutes);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: '시간 ex)18시',
                    ),
                  ),
                  padding: EdgeInsets.all(20.0),
                ),
                Padding(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged:(text){
                      setState((){
                        minutes=int.parse(text);;
                        print(hours);
                        print(minutes);
                        ClockTimeNotification(hours,minutes);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: '분',
                    ),
                  ),
                  padding: EdgeInsets.all(20.0),
                ),
              ]
          ),
        ),
      ),
      ),
    );
  }
}

Future ClockTimeNotification(int hours,int minutes) async {
  final notiTitle = 'PSQI/데일리'; //알람 제목
  final notiDesc = '설문을 할 시간입니다'; //알람 내용
  final result;//권한 확인을 위한 변수

  //----------------------------------------------------------------------------------
  //local notification 플러그인 객체 생성
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,);
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //플랫폼 확인해서 OS 종류에 따라 권한 확인
  //안드로이드 일때
  result=true;
  //----------------------------------------------------------------------------------
  //안드로이드 Notification 옵션
  var android = AndroidNotificationDetails('id', notiTitle,
      channelDescription: notiDesc,
      importance: Importance.max,
      priority: Priority.max,
      color: Color.fromARGB(255, 255, 0, 0)); //여기color는 Notification Icon 배경색

  //IOS Notification 옵션

  //Notificaiton 옵션 값 등록
  var detail = NotificationDetails(android: android);
//----------------------------------------------------------------------------------
  //권한이 있으면 실행.
  if (result==true) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannelGroup('id');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // 스케줄 ID(고유)
      notiTitle, //알람 제목
      notiDesc, //알람 내용
      _setNotiTime(hours,minutes), //알람 시간
      detail,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      //이 옵션은 중요함(옵션 값에따라 시간만 맞춰서 작동할지, 월,일,시간 모두 맞춰서 작동할지 옵션 설정
      //아래와 같이 time으로 설정되어있으면, setNotTime에서 날짜를 아무리 지정해줘도 시간만 동일하면 알림이 발생
      matchDateTimeComponents: DateTimeComponents.time,//또는dayOfMonthAndTime
    );
  }
}

//알람 시간 세팅
tz.TZDateTime _setNotiTime(int hours,int minutes){

  tz.initializeTimeZones();//TimeZone Database 초기화
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));//TimeZone 설정(외국은 다르게!)
  final now = tz.TZDateTime.now(tz.local);
  var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hours, minutes);//알람 시간
  //var test = tz.TZDateTime.now(tz.local).add(const Duration (seconds: 5));
  print('-----------알람 시간 체크----${scheduledDate.toString()}');
  return scheduledDate;
}