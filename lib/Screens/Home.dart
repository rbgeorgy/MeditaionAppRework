import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:meditaion/Screens/Controllers/BottomNavigationBarController.dart';
import 'package:meditaion/Workout/WorkoutAnimated.dart';
import 'package:meditaion/Workout/WorkoutController.dart';

import 'Controllers/TrainPageViewController.dart';

class Home extends StatelessWidget {
  BottomNavigationBarController bottomNavigationController =
      Get.put(BottomNavigationBarController());

  TrainPageViewController trainPageViewController =
      Get.put(TrainPageViewController());

  GlobalKey<WorkoutAnimatedState> keyWorkoutArcAnimatedState = GlobalKey();

  var animatedWorkout;

  @override
  Widget build(context) {
    WorkoutController workoutController = Get.put(WorkoutController(
        trainPageViewController.list[0],
        keyWorkoutArcAnimatedState)); //Вызываться от последней тренировки
    return Obx(() => Scaffold(
        appBar: AppBar(
          //Создать AppBarController
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Text(
              'Тренировка',
              style: TextStyle(),
            ),
          ),
          actions: workoutController.sessionState.value == 'done'
              ? [
                  IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        workoutController.pressOnCenterButton();
                      }),
                  IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
                ]
              : workoutController.sessionState == 'paused'
                  ? [
                      IconButton(
                          icon: Icon(Icons.exposure_plus_1),
                          onPressed: () {
                            workoutController.addCircle();
                          }),
                      IconButton(
                          icon: Icon(Icons.stop),
                          onPressed: () {
                            workoutController.stopButton();
                          }),
                      IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            workoutController.pressOnCenterButton();
                          }),
                      IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
                    ]
                  : [
                      IconButton(
                          icon: Icon(Icons.exposure_plus_1),
                          onPressed: () {
                            workoutController.addCircle();
                          }),
                      IconButton(
                          icon: Icon(Icons.stop),
                          onPressed: () {
                            workoutController.stopButton();
                          }),
                      IconButton(
                          icon: Icon(Icons.pause),
                          onPressed: () {
                            workoutController.pressOnCenterButton();
                          }),
                      IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
                    ],
        ),
        body: Center(child: bottomNavigationController.getWidget()),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 32,
          onTap: (index) => bottomNavigationController.selectedIndex = index,
          currentIndex: bottomNavigationController.selectedIndex,
          unselectedIconTheme:
              IconThemeData(color: Theme.of(context).accentColor),
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).accentColor),
          selectedFontSize: 12.0,
          selectedItemColor: Theme.of(context).accentColor,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  width: 0,
                ),
                label: ''),
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.heartbeat,
              ),
              label: 'Тренировка',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Ionicons.settings,
                  color: Theme.of(context).accentColor,
                ),
                label: 'Управление'),
            BottomNavigationBarItem(
                icon: Icon(
                  LineIcons.bar_chart,
                  color: Theme.of(context).accentColor,
                ),
                label: 'Опыт'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  color: Theme.of(context).accentColor,
                ),
                label: 'Напоминания'),
            BottomNavigationBarItem(
                icon: Icon(
                  LineIcons.sliders,
                  color: Theme.of(context).accentColor,
                ),
                label: 'Настройки')
          ],
        )));
  }
}
