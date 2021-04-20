import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditaion/ComplexVisualElements/DotsIndicator.dart';
import 'package:meditaion/Painting/WorkoutUnanimated.dart';
import 'package:meditaion/Workout/WorkoutAnimated.dart';
import 'package:meditaion/Workout/WorkoutController.dart';
import 'package:meditaion/Workout/WorkoutLogicWidget.dart';
import 'Controllers/TrainPageViewController.dart';

class TrainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TrainPageViewController trainPageViewController = Get.find();
    WorkoutController workoutController = Get.find();

    List<Widget> _pages = [
      Center(
          child: RotatedBox(
              quarterTurns: -1,
              child: Stack(children: [
                WorkoutUnanimated(sessionData: trainPageViewController.list[0]),
                WorkoutAnimated(
                  //параллельно считать анимацию в контроллере и собирать данный виджет, каждый раз исходя из значений в контроллере
                  key: workoutController.keyWorkoutArcAnimatedState,
                  sessionData: trainPageViewController.list[0],
                ),
                WorkoutLogicWidget()
              ]))),
      Center(
          child: RotatedBox(
              quarterTurns: -1,
              child: Stack(children: [
                WorkoutUnanimated(sessionData: trainPageViewController.list[0]),
              ]))),
    ];
    return Stack(
      children: [
        PageView(
          physics: workoutController.sessionState.value != 'done'
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
          controller: trainPageViewController.pageController,
          scrollDirection: Axis.vertical,
          children: _pages,
        ),
        Visibility(
          visible:
              workoutController.sessionState.value != 'done' ? false : true,
          child: Positioned(
            bottom: 0.0,
            right: 0.0,
            top: 0.0,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: DotsIndicator(
                  controller: trainPageViewController.pageController,
                  itemCount: _pages.length,
                  onPageSelected: (int page) {
                    trainPageViewController.pageController.animateToPage(
                      page,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.ease,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
