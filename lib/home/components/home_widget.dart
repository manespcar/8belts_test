import 'package:belts_test/app/theme/belts_theme.dart';
import 'package:belts_test/home/components/home_stepper.dart';
import 'package:belts_test/l10n/l10n.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView(
        children: [
          Align(
            child: Text(
              context.l10n.homePageTitle,
              style: BeltsTheme.themeData.textTheme.headline1,
            ),
          ),
          const HomeStepper(),
        ],
      ),
    );
  }
}
