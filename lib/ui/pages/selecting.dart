import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart';
import 'package:next_test/data/model/library.dart';
import 'package:next_test/utils/yaml_utils.dart';
import 'package:yaml/yaml.dart';

import '../widgets/app_bar.dart';

class NextTestSelectingPage extends StatefulWidget {
  const NextTestSelectingPage({Key? key, this.children}) : super(key: key);
  final List<Child>? children;

  static const route = '/selecting';

  @override
  State<StatefulWidget> createState() => _SelectingState();
}

class _SelectingState extends State<NextTestSelectingPage> {
  late final Future<List<Child>> futureLibraries;

  @override
  void initState() {
    super.initState();
    if (widget.children != null) {
      futureLibraries = Future.value(widget.children);
    } else {
      futureLibraries = _fetchLibraries();
    }
  }

  Widget _buildItem(BuildContext context, Child child) {
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
          Navigator.pushNamed(context, NextTestSelectingPage.route,
              arguments: child.children);
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
      body: FutureBuilder(
        future: futureLibraries,
        builder: (BuildContext context, AsyncSnapshot<List<Child>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildItem(context, snapshot.data![index]),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<List<Library>> _fetchLibraries() async {
  final urls =
      (loadYaml(await rootBundle.loadString("assets/libraries/libraries.yml"))
              as YamlList)
          .toTypedList<String>();
  final libraries = <Library>[];
  for (var url in urls) {
    libraries.add(Library.fromJson(
        (loadYaml(utf8.decode((await get(Uri.parse(url))).bodyBytes))
                as YamlMap)
            .toMap()));
  }
  return libraries;
}
