import 'package:flutter/material.dart';

const String _appTitle = 'NextTest';

void main() => runApp(const NextTestApp());

class NextTestApp extends StatelessWidget {
  const NextTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,

    );
  }
}