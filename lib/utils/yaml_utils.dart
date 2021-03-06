import 'package:yaml/yaml.dart';

extension YamlListConverter on YamlList {
  List<dynamic> toListDeeply() {
    final List<dynamic> result = [];
    forEach((item) {
      if (item is YamlList) {
        result.add(item.toListDeeply());
      } else if (item is YamlMap) {
        result.add(item.toMap());
      } else {
        result.add(item);
      }
    });
    return result;
  }
}

extension YamlMapConverter on YamlMap {
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    forEach((key, value) {
      if (value is YamlMap) {
        map[key] = value.toMap();
      } else if (value is YamlList) {
        map[key] = value.toListDeeply();
      } else {
        map[key] = value;
      }
    });
    return map;
  }
}

extension YamlParser on String {
  Map<String, dynamic> toMap() => (loadYaml(this) as YamlMap).toMap();

  List<dynamic> toList() => (loadYaml(this) as YamlList).toListDeeply();

  List<T> toTypedList<T>() => toList().map((e) => e as T).toList();
}
