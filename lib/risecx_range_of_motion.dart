library risecx_range_of_motion;

import 'package:flutter/widgets.dart';
import 'package:risecx_range_of_motion/services/angles.service.dart';
import 'package:risecx_range_of_motion/widgets/main_widget.dart';

class RisecxRangeOfMotion extends StatelessWidget {
  final JOINTS joint;
  const RisecxRangeOfMotion({Key? key, this.joint = JOINTS.ELBOW})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainWidget(joint: this.joint);
  }
}
