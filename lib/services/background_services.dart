import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_app/models/userModel.dart';
import 'package:fyp_app/providers/auth_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const simpleTaskKey = "be.tramckrijte.workmanagerExample.simpleTask";
const rescheduledTaskKey = "be.tramckrijte.workmanagerExample.rescheduledTask";
const failedTaskKey = "be.tramckrijte.workmanagerExample.failedTask";
const simpleDelayedTask = "be.tramckrijte.workmanagerExample.simpleDelayedTask";
const simplePeriodicTask =
    "be.tramckrijte.workmanagerExample.simplePeriodicTask";
const simplePeriodic1HourTask =
    "be.tramckrijte.workmanagerExample.simplePeriodic1HourTask";
void get(String uid) {
  print('++++++++++++++My DELAY TASK z++++++++++++++++++++++++++++++++++');
  print(uid.toString());
AuthProvider authProvider =AuthProvider();
// authProvider.deletebookTable();
        FirebaseFirestore.instance.collection('Users').doc(uid).update(
        {
          "booktable":false
        }
      ).then((value) {
      
      }).catchError((e){
print('GET  ERROR FUNCTION');
      });
}

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case simpleTaskKey:
        print("$simpleTaskKey was executed. inputData = $inputData");
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("test", true);
        print("Bool** from prefs: ${prefs.getBool("test")}");
       final  String? encodedMap=     prefs.getString("data");
           Map<String,dynamic> decodedMap = json.decode(encodedMap!);
           UserModel a =UserModel.fromMap(decodedMap);
        get(a.uid.toString());

        break;
      case rescheduledTaskKey:
        final key = inputData!['key']!;
        final prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey('unique-$key')) {
          print('has been running before, task is successful');
          return true;
        } else {
          await prefs.setBool('unique-$key', true);
          print('reschedule task');
          return false;
        }
      case failedTaskKey:
        print('failed task');
        return Future.error('failed');
      case simpleDelayedTask:
        // print("$simpleDelayedTask was executed");
        Future.value( (){
        print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
        });

        break;
      case simplePeriodicTask:
        print("$simplePeriodicTask was executed");

        break;
      case simplePeriodic1HourTask:
        print("$simplePeriodic1HourTask was executed");
        break;
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        Directory? tempDir = await getTemporaryDirectory();
        String? tempPath = tempDir.path;
        print(
            "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
        break;
    }

    return Future.value(true);
  });
}
