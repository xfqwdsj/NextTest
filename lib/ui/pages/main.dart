import 'package:flutter/material.dart';
import 'package:next_test/utils/route_utils.dart';

import '../../generated/l10n.dart';
import '../widgets/app_bar.dart';
import 'selecting.dart';

class NextTestMainPage extends StatefulWidget {
  const NextTestMainPage({Key? key}) : super(key: key);

  static const route = '';

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<NextTestMainPage> {
  void _goToHome() {
    Navigator.pushNamed(
        context, RouteUtils.toRoute([NextTestSelectingPage.route]));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: NextTestAppBar(
          context: context,
          title: Text(AppLocalizations.of(context).mainPageTitle),
        ),
        body: Center(
          child: TextButton(onPressed: _goToHome, child: const Text('Go')),
        ),
      );
}
