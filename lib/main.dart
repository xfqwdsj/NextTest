import 'package:flutter/material.dart';
import 'package:next_test/ui/pages/home.dart';

const String appTitle = 'NextTest';

void main() => runApp(const NextTestApp());

class NextTestApp extends StatelessWidget {
  const NextTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (BuildContext context) => const NextTestHomePage(),
      },
      title: appTitle,
    );
  }
}
