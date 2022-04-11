import 'package:belts_test/app/theme/belts_theme.dart';
import 'package:belts_test/l10n/l10n.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: BeltsTheme.themeData.textTheme.headline4,
            ),
            const SizedBox(height: 30),
            Text(
              context.l10n.notFoundPageTitle,
              style: BeltsTheme.themeData.textTheme.headline4,
            )
          ],
        ),
      ),
    );
  }
}
