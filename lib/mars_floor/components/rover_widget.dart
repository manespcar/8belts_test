import 'package:belts_test/constants/constants.dart';
import 'package:flutter/material.dart';

class RoverWidget extends StatelessWidget {
  const RoverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/moon-rover.png',
      height: maxSizeRover,
      width: maxSizeRover,
    );
  }
}
