import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:next_test/ui/pages/main.dart';
import 'package:next_test/ui/pages/selecting.dart';

import 'data/model/library.dart';

void main() => runApp(const NextTestApp());

class NextTestApp extends StatelessWidget {
  const NextTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        NextTestMainPage.route: (BuildContext context) =>
            const NextTestMainPage(),
        NextTestSelectingPage.route: (BuildContext context) =>
            NextTestSelectingPage(
                children:
                    ModalRoute.of(context)?.settings.arguments as List<Child>?),
      },
      initialRoute: NextTestMainPage.route,
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
