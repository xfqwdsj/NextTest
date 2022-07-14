import 'package:markdown/markdown.dart';

extension MarkdownUtils on String {
  String toHtml() => markdownToHtml(this);
}
