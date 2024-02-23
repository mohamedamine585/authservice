import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../repositories/tokenrepository.dart';

Middleware checktokenmiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        if (request.requestedUri.path == "/setname") {
          final token = (request.headers["authorization"])?.split(" ")[1];
          if (token != null) {
            request.context["_id"] =
                Tokenrepository.CheckToken(token: token) as Object;
          } else {
            return Response.unauthorized(
                json.encode({"message": "Invalid token"}));
          }
        } else {
          return await innerHandler(request);
        }
      } catch (e) {
        print(e);
      }
      return Response(404);
    };
  };
}
