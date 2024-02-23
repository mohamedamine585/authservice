import 'dart:convert';

import 'package:shelf/shelf.dart';

Middleware rootmiddleware() {
  return (Handler innerhandler) {
    return (Request request) async {
      if (request.requestedUri.path == "/signin" ||
          request.requestedUri.path == "/signup") {
        final requestbody = await request.readAsString();
        final requestbodydecoded = json.decode(requestbody);

        if (requestbodydecoded["email"] == null ||
            requestbodydecoded["password"] == null) {
          return Response.badRequest(
              body: json.encode({"message": "bad request body format"}));
        }

        return await innerhandler(request);
      }
      return await innerhandler(request);
    };
  };
}
