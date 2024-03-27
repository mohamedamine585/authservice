import 'dart:convert';

import 'package:shelf/shelf.dart';

Middleware tictactoeSchemaMiddleware() {
  return (Handler innerhandler) {
    return (Request request) async {
      if (request.requestedUri.path == "/tictactoesignin" ||
          request.requestedUri.path == "/tictactoesignup") {
        final body = request.context["body"] as Map<String, dynamic>?;
        if (body != null) {
          final tictactoe = body["tictactoe"] as List<dynamic>;

          if (tictactoe.length <= 9 && tictactoe.length >= 4) {
            return await innerhandler(request);
          } else {
            return Response.badRequest(
                body: json.encode({"message": "Bad Request body"}));
          }
        } else {
          return Response.notFound(json.encode({"message": "route not found"}));
        }
      } else {
        return await innerhandler(request);
      }
    };
  };
}
