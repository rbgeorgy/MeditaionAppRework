import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditaion/Abstractions/SessionData.dart';
import 'package:meditaion/Notifications/NotificationMethods.dart';

import 'WorkoutAnimated.dart';

typedef StringValue = void Function(String, String, String);

class WorkoutController extends GetxController {
  @required
  final SessionData sessionData;
  final GlobalKey<WorkoutAnimatedState> workoutArcAnimatedState;
  final List<String> textDatas = const ['Вдох', 'Выдох', 'Задержка'];
  var repeatitions = 0.obs;
  var secondsRemains = 0.obs;
  var secondsRemainsThisCircle = 0;
  var secondsRemainsDisplay = ''.obs;
  var secondsRemainsThisCircleDisplay = ''.obs;
  var breathState = '';
  var _sessionState = 'done'.obs;
  get sessionState => this._sessionState;
  Timer _timer;
  var start = false.obs;

  WorkoutController(this.sessionData, this.workoutArcAnimatedState);

  get keyWorkoutArcAnimatedState => workoutArcAnimatedState;

  @override
  void onInit() {
    repeatitions.value = sessionData.numberOfCircles;
    secondsRemains.value =
        sessionData.numberOfCircles * sessionData.oneCircleDuration;
    secondsRemainsThisCircle = sessionData.oneCircleDuration;
    secondsRemainsDisplay.value = getTimeViewAndShowNotification(true, false);
    secondsRemainsThisCircleDisplay.value =
        getTimeViewAndShowNotification(false, false);

    AwesomeNotifications().actionStream.listen((receivedNotification) {
      processMediaControls(receivedNotification);
    });
  }

  @override
  void onClose() {
    if (_timer != null) _timer.cancel();
    workoutArcAnimatedState.currentState.dispose();
    super.dispose();
  }

  String getTextData() {
    for (int i = 0; i < sessionData.durationLimits.length - 1; i++) {
      if (sessionData.oneCircleDuration - secondsRemainsThisCircle - 1 <
              sessionData.durationLimits[sessionData.ids.length - i - 1] &&
          sessionData.oneCircleDuration - secondsRemainsThisCircle - 1 >=
              sessionData.durationLimits[sessionData.ids.length - i]) {
        breathState = textDatas[sessionData.ids[i].index];
        return textDatas[sessionData.ids[i].index];
      }
    }
    if (secondsRemainsThisCircleDisplay.value == '00:00') {
      breathState = textDatas[sessionData.ids.last.index];
      return textDatas[sessionData.ids.last.index];
    }
    breathState = '';
    return '';
  }

  String getTimeViewAndShowNotification(bool which, bool atEnd) {
    sessionState != 'done'
        ? showNotificationWithActionButtons(
            3,
            sessionState == 'done'
                ? 0
                : sessionState == 'paused'
                    ? 1
                    : 2,
            breathState,
            secondsRemainsDisplay.value)
        : cancelNotification(3);

    int sr = secondsRemains.value;
    int srtc = secondsRemainsThisCircle;
    if (atEnd) {
      sr = sessionData.numberOfCircles * sessionData.oneCircleDuration;
      srtc = sessionData.oneCircleDuration;
    }

    if (which) {
      String minutes = (sr ~/ 60).toString();
      if (minutes == '') minutes = '00';
      String secundes = (sr % 60).toString();
      if (secundes.length == 1) secundes = '0' + secundes;
      final String res = '0' + minutes + ':' + secundes;
      return res;
    } else {
      String minutes = (srtc ~/ 60).toString();
      if (minutes == '') minutes = '00';
      String secundes = (srtc % 60).toString();
      if (secundes.length == 1) secundes = '0' + secundes;
      final String res = '0' + minutes + ':' + secundes;
      return res;
    }
  }

  void startTimer() {
    _sessionState.value = 'going';
    if (secondsRemains.value ==
        sessionData.numberOfCircles * sessionData.oneCircleDuration) {
      secondsRemains--;
      secondsRemainsThisCircle--;
      secondsRemainsDisplay.value = getTimeViewAndShowNotification(true, false);
      secondsRemainsThisCircleDisplay.value =
          getTimeViewAndShowNotification(false, false);
      _sessionState.value = 'going';
    }
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemains.value == 0) {
        stopButton();
        return;
      } else {
        secondsRemains--;
        secondsRemainsThisCircle--;
        secondsRemainsDisplay.value =
            getTimeViewAndShowNotification(true, false);
        secondsRemainsThisCircleDisplay.value =
            getTimeViewAndShowNotification(false, false);
        _sessionState.value = 'going';

        if (secondsRemainsThisCircle == 0) {
          repeatitions--;
          secondsRemainsThisCircle = sessionData.oneCircleDuration;
        }
      }
    });
  }

  void pauseTimer() {
    if (_timer != null) _timer.cancel();
    secondsRemains.value = repeatitions * sessionData.oneCircleDuration;
    secondsRemainsThisCircle = sessionData.oneCircleDuration;
    _sessionState.value = 'paused';
    secondsRemainsDisplay.value = getTimeViewAndShowNotification(true, false);
    secondsRemainsThisCircleDisplay.value =
        getTimeViewAndShowNotification(false, false);
  }

  void pressOnCenterButton() {
    workoutArcAnimatedState.currentState.pressOnCenterButton();
    if (!start.value) {
      start.value = true;
      startTimer();
    } else {
      start.value = false;
      pauseTimer();
    }
  }

  void stopButton() {
    workoutArcAnimatedState.currentState.stopButton();
    _timer.cancel();
    _sessionState.value = 'done';
    start.value = false;
    secondsRemainsDisplay.value = getTimeViewAndShowNotification(true, true);
    secondsRemainsThisCircleDisplay.value =
        getTimeViewAndShowNotification(false, true);
    secondsRemains.value =
        sessionData.numberOfCircles * sessionData.oneCircleDuration;
    secondsRemainsThisCircle = sessionData.oneCircleDuration;
    repeatitions.value = sessionData.numberOfCircles;
  }

  void addCircle() {
    workoutArcAnimatedState.currentState.addCircle();
    secondsRemains += sessionData.oneCircleDuration;
    repeatitions++;
  }

  void processMediaControls(actionReceived) {
    switch (actionReceived.buttonKeyPressed) {
      case 'STOP':
        print('stop');
        stopButton();
        break;
      case 'PAUSE':
        print('pause');
        pressOnCenterButton();
        break;
      case 'ADD_CIRCLE':
        print('add circle');
        addCircle();
        break;

      default:
        break;
    }
  }
}
