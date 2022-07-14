class NextTestRoute {
  static String toRoute(List<String> pathSegments) =>
      '/${Uri(pathSegments: pathSegments).path}';
}
