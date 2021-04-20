import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditaion/Abstractions/SessionData.dart';
import 'package:meditaion/Painting/ArcPainter.dart';
import 'package:meditaion/Workout/WorkoutController.dart';

class WorkoutAnimated extends StatefulWidget {
  @required
  final SessionData sessionData;

  WorkoutAnimated({
    Key key,
    this.sessionData,
  }) : super(key: key);
  @override
  WorkoutAnimatedState createState() => WorkoutAnimatedState();
}

class WorkoutAnimatedState extends State<WorkoutAnimated>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController controller;
  bool start = false;
  int repeatitions;

  @override
  void initState() {
    super.initState();
    WorkoutController tmpController = Get.find();
    repeatitions = tmpController.repeatitions.value;
    start = tmpController.start.value;
    controller = AnimationController(
        duration: Duration(seconds: widget.sessionData.oneCircleDuration),
        vsync: this);
    repeatitions = widget.sessionData.numberOfCircles;

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        repeatitions--;
        controller.reset();
        if (repeatitions != 0)
          controller.forward();
        else {
          start = false;
          repeatitions = widget.sessionData.numberOfCircles;
        }
      } //else if (status == AnimationStatus.dismissed) {}
    });

    _animation = Tween(begin: 0.0, end: 6.2831).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void stopButton() {
    controller.reset();
    start = false;
    repeatitions = widget.sessionData.numberOfCircles;
  }

  void addCircle() {
    repeatitions++;
  }

  void pressOnCenterButton() {
    setState(() {
      if (!start) {
        start = true;
        controller.forward();
      } else {
        start = false;
        controller.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: AnimatedBuilder(
        builder: (_, build) {
          return CustomPaint(
            painter: ArcPainter(_animation.value, widget.sessionData.limits,
                widget.sessionData.ids),
          );
        },
        animation: controller,
      ),
    );
  }
}
