import 'package:belts_test/app/theme/belts_theme.dart';
import 'package:belts_test/l10n/l10n.dart';
import 'package:belts_test/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _router = Routes.getRoutes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: BeltsTheme.themeData,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
