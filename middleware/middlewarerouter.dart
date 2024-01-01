import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'queryfmiddleware.dart';

Middleware rootmiddleware() {
  return (Handler innerhandler) {
    return (Request request) async {
      if (request.method == 'GET' && request.requestedUri.path == "/Signin") {
        String rstr = queryfMiddleware(request);
        return (rstr != "")
            ? (Response.badRequest(body: json.encode({"message": rstr})))
            : await innerhandler(request);
      }
      return await innerhandler(request);
    };
  };
}
