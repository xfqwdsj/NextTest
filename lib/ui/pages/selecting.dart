import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:next_test/data/model/library.dart';
import 'package:next_test/ui/pages/testing.dart';
import 'package:next_test/utils/yaml_utils.dart';

import '../../generated/l10n.dart';
import '../../utils/route_utils.dart';
import '../widgets/app_bar.dart';

class NextTestSelectingPage extends StatefulWidget {
  const NextTestSelectingPage({Key? key, this.path}) : super(key: key);
  final List<int>? path;

  static const route = 'selecting';

  @override
  State<StatefulWidget> createState() => _SelectingState();
}

class _SelectingState extends State<NextTestSelectingPage> {
  Widget body = const Center(child: CircularProgressIndicator());

  @override
  void initState() {
    super.initState();
    _fetchLibraries().then((value) {
      setState(() {
        body = ListView.builder(
            itemCount: value.length,
            itemBuilder: (BuildContext context, int index) =>
                _buildItem(context, value, index));
      });
    }).catchError((e) {
      Navigator.pushReplacementNamed(context, RouteUtils.toRoute(['404']),
          arguments: e);
    });
  }

  Widget _buildItem(BuildContext context, List<Child> children, int index) {
    final child = children[index];
    Widget? leading;
    String subtitle = child.description;
    bool? isFolder;

    if (child.url != null) {
      leading = const Icon(Icons.book);
      isFolder = false;
    } else if (child.children != null) {
      leading = const Icon(Icons.folder);
      isFolder = true;
    }

    if (child is Library) {
      subtitle +=
          '\n${AppLocalizations.of(context).selectingPageItemAuthorPrefix}${child.author}';
    }

    void _onTap() {
      if (isFolder == true) {
        Navigator.pushNamed(
            context,
            RouteUtils.toRoute([
              NextTestSelectingPage.route,
              ...?(widget.path?.map((e) => e.toString())),
              index.toString()
            ]));
      } else if (isFolder == false) {
        Navigator.pushNamedAndRemoveUntil(
            context,
            RouteUtils.toRoute([NextTestTestingPage.route, child.url!]),
            (route) => route.settings.name == '/');
      }
    }

    return ListTile(
      leading: leading,
      title: Text(child.title),
      subtitle: Text(subtitle),
      isThreeLine: child is Library,
      onTap: _onTap,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: NextTestAppBar(
          context: context,
          title: Text(AppLocalizations.of(context).selectingPageTitle),
        ),
        body: body,
      );

  Future<List<Child>> _fetchLibraries() async {
    var urls = (await rootBundle.loadString("assets/libraries/libraries.yml"))
        .toTypedList<String>();
    if (widget.path?.isNotEmpty == true) {
      final index = widget.path!.first;
      urls = [urls[index]];
    }
    var libraries = <Child>[];
    for (var url in urls) {
      libraries.add(Library.fromJson(
          utf8.decode((await get(Uri.parse(url))).bodyBytes).toMap()));
    }
    if (widget.path != null) {
      for (var i in widget.path!) {
        libraries = libraries[i].children ?? [];
      }
    }
    return libraries;
  }
}
