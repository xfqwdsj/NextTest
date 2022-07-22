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
  String get value => selected.toString();

  List<int> selected = [];
}

class FillingQuestionAnswer extends Answer {
  @override
  String get value => answers.join(',');

  List<String> answers = [];
}
