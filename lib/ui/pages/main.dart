import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import 'home.dart';

class NextTestMainPage extends StatefulWidget {
  const NextTestMainPage({Key? key}) : super(key: key);

  static const route = '/';

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<NextTestMainPage> {
  void _goToHome() {
    Navigator.pushNamed(context, NextTestHomePage.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NextTestAppBar(
        title: Text('NextTest'),
      ),
      body: Center(
        child: TextButton(onPressed: _goToHome, child: const Text('Go')),
      ),
    );
  }
}
