import 'package:belts_test/app/theme/belts_theme.dart';
import 'package:flutter/material.dart';

class InstructionsWidget extends StatelessWidget {
  const InstructionsWidget({
    Key? key,
    required this.instruction,
    required this.logInstruction,
  }) : super(key: key);

  final String instruction;
  final int logInstruction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            instruction,
            style: BeltsTheme.themeData.textTheme.subtitle1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: logInstruction == 1
              ? const Icon(
                  Icons.check,
                  color: Colors.green,
                )
              : logInstruction == 0
                  ? const Icon(
                      Icons.clear,
                      color: Colors.red,
                    )
                  : Container(),
        ),
      ],
    );
  }
}
