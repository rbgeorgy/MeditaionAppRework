import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditaion/Abstractions/SessionData.dart';
import 'package:meditaion/Abstractions/TypesEnum.dart';

class TrainPageViewController extends GetxController {
  final List<SessionData> list = [
    SessionData(
        [0, 2, 5, 2, 5, 3],
        17,
        [
          TypesEnum.breathIn,
          TypesEnum.breathOut,
          TypesEnum.breathIn,
          TypesEnum.breathOut,
          TypesEnum.hold
        ],
        2)
  ];
  final pageController = new PageController();

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
