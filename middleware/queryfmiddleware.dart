import 'package:shelf/shelf.dart';

String queryfMiddleware(Request request) {
  if (request.url.queryParameters.entries.length < 2) {
    return "Invalid query parameters";
  } else if (request.url.queryParameters.entries.elementAt(0).key !=
          "playername" ||
      request.url.queryParameters.entries.elementAt(1).key != "password") {
    return "Invalid Query parameters keys";
  } else if (request.url.queryParameters.entries.elementAt(0).value.length <
          4 ||
      request.url.queryParameters.entries.elementAt(1).value.length < 6) {
    return "Invalid Query parameters values";
  } else {
    return "";
  }
}
