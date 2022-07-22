import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:next_test/data/model/question_set.dart';
import 'package:next_test/ui/widgets/app_bar.dart';
import 'package:next_test/utils/html_utils.dart';
import 'package:next_test/utils/yaml_utils.dart';

import '../../generated/l10n.dart';
import '../../utils/route_utils.dart';

class NextTestTestingPage extends StatefulWidget {
  const NextTestTestingPage({Key? key, required this.url}) : super(key: key);
  final String url;

  static const route = 'testing';

  @override
  State<StatefulWidget> createState() => _TestingState();
}

class _TestingState extends State<NextTestTestingPage> {
  Widget body = const Center(child: CircularProgressIndicator());

  @override
  void initState() {
    super.initState();
    _fetchQuestionSet().then((value) {
      setState(() {
        if (value.random) {
          value.questions.shuffle();
        }
        body = _buildBody(value);
      });
    }).catchError((e) {
      Navigator.pushReplacementNamed(context, RouteUtils.toRoute(path: ['404']),
          arguments: e);
    });
  }

  Widget _buildBody(QuestionSet set) => ListView.builder(
      itemCount: set.questions.length,
      itemBuilder: (BuildContext context, int index) =>
          QuestionView(question: set.questions[index]));

  void _done() {}

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: NextTestAppBar(
          context: context,
          title: Text(AppLocalizations.of(context).testingPageTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: _done,
            ),
          ],
        ),
        body: body,
      );

  Future<QuestionSet> _fetchQuestionSet() async => QuestionSet.fromJson(
      utf8.decode((await get(Uri.parse(widget.url))).bodyBytes).toMap());
}

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  State<StatefulWidget> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: Html(data: widget.question.question.toHtml()),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  labelText: widget.question.blanks![0].placeholder,
                ),
              ),
            ),
          ]),
        ),
      );
}
