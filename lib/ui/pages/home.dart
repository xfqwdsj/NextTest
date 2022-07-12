import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:next_test/data/model/library.dart';
import 'package:next_test/utils/yaml_utils.dart';
import 'package:yaml/yaml.dart';

import '../../main.dart';
import '../widgets/app_bar.dart';

class NextTestHomePage extends StatefulWidget {
  const NextTestHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<NextTestHomePage> {
  late Future<List<Library>> futureLibraries;

  @override
  void initState() {
    super.initState();
    futureLibraries = _fetchLibraries();
  }

  Widget _buildLibraryItem(BuildContext context, Library library) {
    Widget? leading;

    if (library.url != null) {
      leading = IconButton(
        icon: const Icon(Icons.book),
        onPressed: () {},
      );
    } else if (library.children != null) {
      leading = IconButton(
        icon: const Icon(Icons.folder),
        onPressed: () {},
      );
    }

    return ListTile(
      leading: leading,
      title: Text(library.title),
      subtitle: Text(library.description),
      onTap: () {
        // Not yet implemented.
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NextTestAppBar(
        title: Text(appTitle),
      ),
      body: FutureBuilder(
        future: futureLibraries,
        builder: (BuildContext context, AsyncSnapshot<List<Library>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildLibraryItem(context, snapshot.data![index]),
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
