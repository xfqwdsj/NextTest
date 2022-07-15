class RouteUtils {
  static String toRoute(
          {required List<String> path, Map<String, dynamic>? query}) =>
      '/${Uri(pathSegments: path, queryParameters: query).toString()}';
}
