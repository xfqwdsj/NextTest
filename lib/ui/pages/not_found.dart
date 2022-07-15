import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../widgets/app_bar.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({Key? key, this.error}) : super(key: key);

  final Object? error;

  @override
  State<StatefulWidget> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  String text = '';

  @override
  void initState() {
    super.initState();
    if (widget.error != null) {
      text = '\n${widget.error}';
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: NextTestAppBar(
          context: context,
          title: Text(AppLocalizations.of(context).notFoundPageTitle),
        ),
        body: Center(
            child: Text(
                '${AppLocalizations.of(context).notFoundPageContent}$text')),
      );
}
