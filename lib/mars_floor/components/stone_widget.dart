import 'package:belts_test/constants/constants.dart';
import 'package:flutter/material.dart';

class StoneWidget extends StatelessWidget {
  const StoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/stone-icon.png',
      height: maxSizeRover,
      width: maxSizeRover,
    );
  }
}
