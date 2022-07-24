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
  List<Child>? list;

  void _onItemTap(int index) {
    if (list![index].children != null) {
      Navigator.pushNamed(
          context,
          RouteUtils.toRoute(path: [
            NextTestSelectingPage.route,
            ...?(widget.path?.map((e) => e.toString())),
            index.toString()
          ]));
    } else if (list![index].url != null) {
      Navigator.pushNamedAndRemoveUntil(
          context,
          RouteUtils.toRoute(
              path: [NextTestTestingPage.route],
              query: {'url': list![index].url}),
          (route) => route.settings.name == '/');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLibraries().then((value) {
      setState(() {
        list = value;
      });
    }).catchError((e) {
      Navigator.pushReplacementNamed(context, RouteUtils.toRoute(path: ['404']),
          arguments: e);
    });
  }

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

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: NextTestAppBar(
          context: context,
          title: Text(AppLocalizations.of(context).selectingPageTitle),
        ),
        body: Builder(builder: (context) {
          if (list == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: list!.length,
            itemBuilder: (context, index) => ListTile(
              leading: Builder(builder: (context) {
                if (list![index].url != null) {
                  return const Icon(Icons.book);
                } else if (list![index].children != null) {
                  return const Icon(Icons.folder);
                } else {
                  return const Icon(Icons.error);
                }
              }),
              title: Text(list![index].title),
              subtitle: Builder(builder: (context) {
                final child = list![index];
                String subtitle = child.description;
                if (child is Library) {
                  subtitle +=
                      '\n${AppLocalizations.of(context).selectingPageItemAuthorPrefix}${child.author}';
                }
                return Text(subtitle);
              }),
              isThreeLine: list![index] is Library,
              onTap: () => _onItemTap(index),
            ),
          );
        }),
      );
}
