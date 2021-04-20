import 'package:flutter/material.dart';
import 'package:meditaion/Abstractions/SessionData.dart';

import 'ArcPainterUnanimated.dart';

class WorkoutUnanimated extends StatelessWidget {
  @required
  final SessionData sessionData;

  const WorkoutUnanimated({Key key, this.sessionData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: CustomPaint(
        painter: ArcPainterUnanimated(sessionData.limits, sessionData.ids),
      ),
    );
  }
}
