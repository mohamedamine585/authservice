import 'dart:convert';

import 'package:shelf/shelf.dart';

Middleware rootmiddleware() {
  return (Handler innerhandler) {
    return (Request request) async {
      if (request.requestedUri.path == "/signin" ||
          request.requestedUri.path == "/signup" ||
          request.requestedUri.path == "/setname" ||
          request.requestedUri.path == "/setemail" ||
          request.requestedUri.path == "/delete" ||
          request.requestedUri.path == "/getdoc" ||
          request.requestedUri.path == "/tictactoein" ||
          request.requestedUri.path == "/tictactoe" ||
          request.requestedUri.path == "/verifyemail" ||
          request.requestedUri.path == "/player") {
        return await innerhandler(request);
      } else {
        return Response.notFound(json.encode({"message": "route not found"}));
      }
    };
  };
}
