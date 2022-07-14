import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:next_test/ui/pages/main.dart';
import 'package:next_test/ui/pages/not_found.dart';
import 'package:next_test/ui/pages/selecting.dart';

void main() => runApp(const NextTestApp());

class NextTestApp extends StatelessWidget {
  const NextTestApp({Key? key}) : super(key: key);

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final path = Uri.parse(settings.name ?? '').pathSegments;
    if (path.isEmpty) {
      return MaterialPageRoute(
          builder: (context) => const NextTestMainPage(), settings: settings);
    }
    switch (path.first) {
      case NextTestSelectingPage.route:
        return MaterialPageRoute(
            builder: (context) => NextTestSelectingPage(
                path: path.skip(1).map((e) => int.parse(e)).toList()),
            settings: settings);
      default:
        return MaterialPageRoute(
            builder: (context) => const NotFoundPage(), settings: settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _onGenerateRoute,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appName,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
