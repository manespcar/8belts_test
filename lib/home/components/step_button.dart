import 'package:flutter/material.dart';

class StepButton extends StatelessWidget {
  const StepButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
