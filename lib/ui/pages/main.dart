import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';

class NextTestMainPage extends StatefulWidget {
  const NextTestMainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<NextTestMainPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NextTestAppBar(
        title: Text('NextTest'),
      ),
      body: Center(
        child: Text('Hello, world!'),
      ),
    );
  }
}
