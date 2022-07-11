import 'package:flutter/material.dart';

const String _appTitle = 'NextTest';

void main() => runApp(const NextTestApp());

class NextTestApp extends StatelessWidget {
  const NextTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (BuildContext context) => const NextTestHomePage(),
      },
      title: _appTitle,
    );
  }
}

class NextTestHomePage extends StatelessWidget {
  const NextTestHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_appTitle),
      ),
      body: const Center(
        child: Text('Hello, world!'),
      ),
    );
  }
}