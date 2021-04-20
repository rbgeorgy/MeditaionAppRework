import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'WorkoutController.dart';

class WorkoutLogicWidget extends StatelessWidget {
  final WorkoutController workoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: RotatedBox(
        quarterTurns: 1,
        child: Obx(() => Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Тренировка\n${workoutController.secondsRemainsDisplay}\n',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Text(
                      workoutController.start.value == true
                          ? workoutController.getTextData()
                          : '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    Text(
                      '\nКруг\n${workoutController.secondsRemainsThisCircleDisplay}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: workoutController.start.value
                        ? SizedBox(
                            height: 80,
                            width: 80,
                          )
                        : Icon(
                            Icons.play_arrow,
                            size: 80,
                            color: Colors.blue,
                          ),
                    onPressed: () {
                      // setState(() {
                      workoutController.pressOnCenterButton();
                      // });
                    }),
              ],
            )),
      ),
    );
  }
}
