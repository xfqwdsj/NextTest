import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:next_test/data/answer.dart';
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
      itemBuilder: (BuildContext context, int index) {
        Answer answer;
        if (set.questions[index].type == QuestionType.selection) {
          if (set.questions[index].selectionType == SelectionType.single) {
            answer = SingleSelectionQuestionAnswer();
          } else {
            answer = MultipleSelectionQuestionAnswer();
          }
        } else {
          answer = FillingQuestionAnswer();
        }
        return QuestionView(
          question: set.questions[index],
          answer: answer,
        );
      });

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
  const QuestionView({Key? key, required this.question, required this.answer})
      : super(key: key);

  final Question question;
  final Answer answer;

  @override
  State<StatefulWidget> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  Widget _buildOption(int index) {
    if (widget.question.selectionType == SelectionType.single) {
      final answer = widget.answer as SingleSelectionQuestionAnswer;
      return RadioListTile(
        value: index,
        groupValue: answer.selected,
        onChanged: (int? value) {
          setState(() {
            answer.selected = value;
          });
        },
        title: Html(data: widget.question.options![index].title.toHtml()),
      );
    } else {
      final answer = widget.answer as MultipleSelectionQuestionAnswer;
      return CheckboxListTile(
        value: answer.selected.contains(index),
        onChanged: (value) {
          setState(() {
            if (value == true) {
              answer.selected.add(index);
            } else {
              answer.selected.remove(index);
            }
          });
        },
        title: Html(data: widget.question.options![index].title.toHtml()),
        controlAffinity: ListTileControlAffinity.leading,
      );
    }
  }

  Widget _buildTextField(int index) => TextField(
        decoration: InputDecoration(
          labelText: widget.question.blanks![index].placeholder,
        ),
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          (widget.answer as FillingQuestionAnswer).answers[index] = value;
        },
      );

  String answer = '';

  void _updateAnswer() {
    answer = '';
    if (widget.question.type == QuestionType.selection) {
      for (var element in widget.question.options!) {
        if (element.isCorrect) {
          setState(() {
            answer += '\n${element.title.toHtml()}';
          });
        }
      }
    } else {
      for (var element in widget.question.blanks!) {
        setState(() {
          answer += '\n${element.answer}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            TextButton(onPressed: _updateAnswer, child: const Text('显示答案')),
            Container(
              padding: const EdgeInsets.all(5),
              child: Html(data: widget.question.question.toHtml()),
            ),
            if (answer.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(5),
                child: Html(data: answer),
              ),
            Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  if (widget.question.type == QuestionType.selection)
                    for (int i = 0; i < widget.question.options!.length; i++)
                      _buildOption(i),
                  if (widget.question.type == QuestionType.filling)
                    for (int i = 0; i < widget.question.blanks!.length; i++)
                      _buildTextField(i),
                ],
              ),
            )
          ]),
        ),
      );
}
