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
  QuestionSet? questionSet;
  Widget body = const Center(child: CircularProgressIndicator());

  Widget _buildBody() => TabBarView(children: [
        for (var question in questionSet!.questions)
          QuestionView(question: question)
      ]);

  @override
  void initState() {
    super.initState();
    _fetchQuestionSet().then((value) {
      setState(() {
        questionSet = value;
        body = _buildBody();
      });
    }).catchError((e) {
      Navigator.pushReplacementNamed(context, RouteUtils.toRoute(['404']),
          arguments: e);
    });
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: questionSet?.questions.length ?? 0,
      child: Scaffold(
        appBar: NextTestAppBar(
          context: context,
          title: Text(AppLocalizations.of(context).testingPageTitle),
          bottom: TabBar(
            tabs: [
              for (var i = 0; i < (questionSet?.questions.length ?? 0); i++)
                Tab(
                    text: AppLocalizations.of(context)
                        .testingPageTabItemTitle(i + 1))
            ],
            isScrollable: true,
          ),
        ),
        body: body,
      ));

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
  Widget build(BuildContext context) => SingleChildScrollView(
          child: Column(children: [
        Container(
          padding: const EdgeInsets.all(5),
          child: Html(data: widget.question.question.toHtml()),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          child: TextField(
            decoration: InputDecoration(
              labelText: widget.question.banks![0].placeholder,
            ),
          ),
        ),
      ]));
}
