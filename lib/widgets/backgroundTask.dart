import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/services/background_services.dart';
import 'package:workmanager/workmanager.dart';

class BackgroubdTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             ElevatedButton(
                  child: Text("Register OneOff Task of 1 min delay"),
                  onPressed: () {
                    Workmanager()
                        .registerOneOffTask(simpleTaskKey, simpleTaskKey,
                            inputData: <String, dynamic>{
                              'int': "MOHSIN IRFAAN",
                              'bool': true,
                              'double': 1.0,
                              'string': 'string',
                              'array': [1, 2, 3],
                           
                            },
                            initialDelay: Duration(minutes: 3));
                  },
                ),

                ElevatedButton(
                onPressed: () async {
                  var uniqueId = DateTime.now().second.toString();
         

                  await Workmanager()
                      .cancelAll();
                },
                child: Text('CANCEL'))
          ],
        ),
      ),
    );
  }
}

class BackGroundWork {
  static sendData() {
    print('HIIIIIIIIIIIIIIIIIIIIIIIIIIIII');
  }

  // static String taskName = 'firsttask';
  // static void callbackDispatcher() {
  //   Workmanager().executeTask((taskName, inputData) {
  //     switch (taskName) {
  //       case 'firsttask':
  //         print('MAAAAA');
  //         break;
  //       case 'firsttask':
  //         sendData();
  //         break;
  //       default:
  //       print("DEFAULT");
  //     }
  //     return Future.value(true);
  //   });
  // }
}
