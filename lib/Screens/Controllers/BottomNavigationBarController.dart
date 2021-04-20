import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meditaion/Screens/TrainPageView.dart';
import 'package:meditaion/Workout/WorkoutController.dart';

class BottomNavigationBarController extends GetxController {
  final _selectedIndex = 1.obs;

  get selectedIndex => this._selectedIndex.value;
  set selectedIndex(index) => index == 0
      ? _selectedIndex.value = _selectedIndex.value
      : _selectedIndex.value = index;

  StatelessWidget getWidget() {
    switch (selectedIndex) {
      case 1:
        return TrainPageView();
      default:
        WorkoutController temp = Get.find();
        if (temp != null && temp.start.value) temp?.pressOnCenterButton();
        return Container();
    }
  }
}
