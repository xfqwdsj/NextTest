import 'package:flutter/material.dart';

abstract class Answer {
  String get value;
}

class SingleSelectionQuestionAnswer extends Answer {
  @override
  String get value => selected.toString();

  int? selected;
}

class MultipleSelectionQuestionAnswer extends Answer {
  @override
  String get value => selected.join(',');

  List<int> selected = [];
}

class FillingQuestionAnswer extends Answer {
  @override
  String get value => controllers.map((c) => c.text).join(',');

  List<TextEditingController> controllers = [];
}
