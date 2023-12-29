import 'package:shelf/shelf.dart';

Middleware queryfMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      if (request.method == 'GET') {
        if (request.url.queryParameters.entries.length < 2) {
          return Response.badRequest(body: "Invalid Query parameters");
        } else if (request.url.queryParameters.entries.elementAt(0).key !=
                "playername" ||
            request.url.queryParameters.entries.elementAt(1).key !=
                "password") {
          return Response.badRequest(body: "Invalid Query parameters keys");
        } else if (request.url.queryParameters.entries
                    .elementAt(0)
                    .value
                    .length <
                4 ||
            request.url.queryParameters.entries.elementAt(1).value.length < 6) {
          return Response.badRequest(body: "Invalid Query parameters values");
        }
      }
      return await innerHandler(request);
    };
  };
}
