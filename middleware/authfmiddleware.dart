import 'dart:convert';

import 'package:shelf/shelf.dart';

// check the request format
Middleware authMiddleware() {
  return (Handler innerhandler) {
    return (Request request) async {
      try {
        if (request.requestedUri.path == "/signin" ||
            request.requestedUri.path == "/signup") {
          final requestbody = await request.readAsString();
          final requestbodydecoded = json.decode(requestbody);

          if (requestbodydecoded["email"] == null ||
              requestbodydecoded["password"] == null) {
            return Response.badRequest(
                body: json.encode({"message": "bad request body format"}));
          }
          request = request.change(context: {"body": requestbodydecoded});
        } else if (request.requestedUri.path == "/tictactoesignin" ||
            request.requestedUri.path == "/tictactoesignup") {
          final requestbody = await request.readAsString();
          final requestbodydecoded = json.decode(requestbody);

          if (requestbodydecoded["email"] == null ||
              requestbodydecoded["tictactoe"] == null) {
            return Response.badRequest(
                body: json.encode({"message": "bad request body format"}));
          }
          request = request.change(context: {"body": requestbodydecoded});
        }

        return await innerhandler(request);
      } catch (e) {
        print(e);
      }
      return Response(404);
    };
  };
}
