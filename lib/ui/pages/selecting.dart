import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart';
import 'package:next_test/data/model/library.dart';
import 'package:next_test/utils/yaml_utils.dart';
import 'package:yaml/yaml.dart';

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
    _fetchLibraries(widget.path).then((value) {
      setState(() {
        body = ListView.builder(
            itemCount: value.length,
            itemBuilder: (BuildContext context, int index) =>
                _buildItem(context, value, index));
      });
    }).catchError((e) {
      Navigator.pushReplacementNamed(context, NextTestRoute.toRoute(['404']));
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
      '\n${AppLocalizations.of(context)?.selectingPageItemAuthorPrefix}${child.author}';
    }

    return ListTile(
      leading: leading,
      title: Text(child.title),
      subtitle: Text(subtitle),
      isThreeLine: child is Library,
      onTap: () {
        if (isFolder == true) {
          Navigator.pushNamed(
              context,
              NextTestRoute.toRoute([
                NextTestSelectingPage.route,
                ...?(widget.path?.map((e) => e.toString())),
                index.toString()
              ]));
        } else if (isFolder == false) {
          //Not implemented yet.
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NextTestAppBar(
        title: Text(AppLocalizations.of(context)!.selectingPageTitle),
      ),
      body: body,
    );
  }
}

Future<List<Child>> _fetchLibraries(List<int>? path) async {
  var urls =
      (loadYaml(await rootBundle.loadString("assets/libraries/libraries.yml"))
              as YamlList)
          .toTypedList<String>();
  if (path?.isNotEmpty == true) {
    final index = path!.first;
    urls = [urls[index]];
  }
  var libraries = <Child>[];
  for (var url in urls) {
    libraries.add(Library.fromJson(
        (loadYaml(utf8.decode((await get(Uri.parse(url))).bodyBytes))
                as YamlMap)
            .toMap()));
  }
  if (path != null) {
    for (var i in path) {
      libraries = libraries[i].children ?? [];
    }
  }
  return libraries;
}
