import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/app_bar.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: NextTestAppBar(
          title: Text(AppLocalizations.of(context)!.notFoundPageTitle),
        ),
        body: Center(
            child: Text(AppLocalizations.of(context)!.notFoundPageContent)),
      );
}
