import 'dart:math';
import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.blue,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  static const double _dotSize = 30.0;
  static const double _pressOnDotZoom = 1.2;
  static const double _spacingBetweenDots = 60.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_pressOnDotZoom - 1.0) * selectedness;
    return new Container(
      height: _spacingBetweenDots,
      child: new Center(
        child: ClipOval(
          child: new Material(
            color: color.withOpacity(0.7),
            type: MaterialType.circle,
            child: new Container(
              width: _dotSize * zoom,
              height: _dotSize * zoom,
              child: new InkWell(
                onTap: () => onPageSelected(index),
                child: Center(
                  child: Text(''), //Сюда первые буквы названия
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
