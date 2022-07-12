import 'package:flutter/material.dart';
import 'package:next_test/ui/pages/home.dart';
import 'package:next_test/ui/pages/main.dart';

import 'data/model/library.dart';

const String appTitle = 'NextTest';

void main() => runApp(const NextTestApp());

class NextTestApp extends StatelessWidget {
  const NextTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        NextTestMainPage.route: (BuildContext context) =>
            const NextTestMainPage(),
        NextTestHomePage.route: (BuildContext context) => NextTestHomePage(
            children:
                ModalRoute.of(context)?.settings.arguments as List<Child>?),
      },
      initialRoute: NextTestMainPage.route,
      title: appTitle,
    );
  }
}
