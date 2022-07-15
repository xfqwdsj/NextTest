import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:next_test/ui/pages/main.dart';
import 'package:next_test/ui/pages/not_found.dart';
import 'package:next_test/ui/pages/selecting.dart';
import 'package:next_test/ui/pages/testing.dart';

import 'generated/l10n.dart';

void main() => runApp(const NextTestApp());

class NextTestApp extends StatelessWidget {
  const NextTestApp({Key? key}) : super(key: key);

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');
    final path = uri.pathSegments;
    if (path.isEmpty) {
      return MaterialPageRoute(
          builder: (context) => const NextTestMainPage(), settings: settings);
    }
    if (path.first == NextTestSelectingPage.route) {
      return MaterialPageRoute(
          builder: (context) => NextTestSelectingPage(
              path: path.skip(1).map((e) => int.parse(e)).toList()),
          settings: settings);
    }
    if (path.first == NextTestTestingPage.route) {
      return MaterialPageRoute(
          builder: (context) =>
              NextTestTestingPage(url: uri.queryParameters['url']!),
          settings: settings);
    }
    return MaterialPageRoute(
        builder: (context) => NotFoundPage(error: settings.arguments),
        settings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _onGenerateRoute,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context).appName,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
    );
  }
}
