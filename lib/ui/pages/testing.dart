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
  QuestionSet? _questionSet;
  bool _isDone = false;
  final List<int> _selectedChips = [];

  @override
  void initState() {
    super.initState();
    _fetchQuestionSet().then((value) {
      if (value.random) {
        value.questions.shuffle();
      }
      setState(() {
        _questionSet = value;
      });
    }).catchError((e) {
      Navigator.pushReplacementNamed(context, RouteUtils.toRoute(path: ['404']),
          arguments: e);
    });
  }

  void _done() {
    setState(() {
      _isDone = true;
    });
  }

  String _getChipLabel(int type) {
    switch (type) {
      case 0:
        return AppLocalizations.of(context).testingPageCorrectChipLabel;
      case 1:
        return AppLocalizations.of(context).testingPageWrongChipLabel;
      case 2:
        return AppLocalizations.of(context).testingPagePendingChipLabel;
      default:
        return '';
    }
  }

  Widget _buildChip(int type) => Container(
      padding: const EdgeInsets.all(4),
      child: FilterChip(
        label: Text(_getChipLabel(type)),
        selected: _selectedChips.contains(type),
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedChips.add(type);
            } else {
              _selectedChips.remove(type);
            }
          });
        },
      ));

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
        body: Builder(builder: (context) {
          if (_questionSet == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              if (_isDone)
                Wrap(
                  children: [
                    _buildChip(0),
                    _buildChip(1),
                    _buildChip(2),
                  ],
                ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Answer answer;
                  if (_questionSet!.questions[index].type ==
                      QuestionType.selection) {
                    if (_questionSet!.questions[index].selectionType ==
                        SelectionType.single) {
                      answer = SingleSelectionQuestionAnswer();
                    } else {
                      answer = MultipleSelectionQuestionAnswer();
                    }
                  } else {
                    answer = FillingQuestionAnswer(
                        _questionSet!.questions[index].blanks!.length);
                  }
                  return QuestionView(
                    question: _questionSet!.questions[index],
                    answer: answer,
                    enabled: !_isDone,
                  );
                },
                itemCount: _questionSet!.questions.length,
              ))
            ],
          );
        }),
      );

  Future<QuestionSet> _fetchQuestionSet() async => QuestionSet.fromJson(
      utf8.decode((await get(Uri.parse(widget.url))).bodyBytes).toMap());
}

class QuestionView extends StatefulWidget {
  const QuestionView(
      {Key? key,
      required this.question,
      required this.answer,
      required this.enabled})
      : super(key: key);

  final Question question;
  final Answer answer;
  final bool enabled;

  @override
  State<StatefulWidget> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
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
                      Builder(builder: (context) {
                        if (widget.question.selectionType ==
                            SelectionType.single) {
                          final answer =
                              widget.answer as SingleSelectionQuestionAnswer;
                          return RadioListTile(
                            value: i,
                            groupValue: answer.selected,
                            onChanged: widget.enabled
                                ? (int? value) {
                                    setState(() {
                                      answer.selected = value;
                                    });
                                  }
                                : null,
                            title: Html(
                                data:
                                    widget.question.options![i].title.toHtml()),
                          );
                        } else {
                          final answer =
                              widget.answer as MultipleSelectionQuestionAnswer;
                          return CheckboxListTile(
                            value: answer.selected.contains(i),
                            onChanged: widget.enabled
                                ? (value) {
                                    setState(() {
                                      if (value == true) {
                                        answer.selected.add(i);
                                      } else {
                                        answer.selected.remove(i);
                                      }
                                    });
                                  }
                                : null,
                            title: Html(
                                data:
                                    widget.question.options![i].title.toHtml()),
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        }
                      }),
                  if (widget.question.type == QuestionType.filling)
                    for (int i = 0; i < widget.question.blanks!.length; i++)
                      TextField(
                        controller: (widget.answer as FillingQuestionAnswer)
                            .controllers[i],
                        decoration: InputDecoration(
                          labelText: widget.question.blanks![i].placeholder,
                        ),
                        textInputAction: TextInputAction.next,
                        enabled: widget.enabled,
                      )
                ],
              ),
            )
          ]),
        ),
      );
}
