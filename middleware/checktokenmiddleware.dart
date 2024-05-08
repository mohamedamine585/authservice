import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../repositories/tokenrepository.dart';

Middleware checktokenmiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        if (request.requestedUri.path == "/setname" ||
            request.requestedUri.path == "/setemail" ||
            request.requestedUri.path == "/getdoc" ||
            request.requestedUri.path == "/deleteaccount" ||
            request.requestedUri.path == "/verifyemail" ||
            request.requestedUri.path == "/player") {
          String? token = request.headers["Authorization"];

          token = token?.split(" ")[1];

          if (token != null) {
            print(token);
            request = request.change(
                context: {"_id": Tokenrepository.CheckToken(token: token)});
          } else {
            return Response.unauthorized(
                json.encode({"message": "Invalid token"}));
          }
        }

        final Response response = await innerHandler(request);

        return response;
      } catch (e) {
        print(e);
      }
      return Response(404);
    };
  };
}
