import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/authrepository.dart';

Future<Response> signinHandler(Request req) async {
  try {
    final token = await Authrepository.signIn(
        playername: req.url.queryParameters.entries.elementAt(0).value,
        password: req.url.queryParameters.entries.elementAt(1).value);
    if (token == null) {
      return Response.ok(json.encode({"message": "Signin failed"}),
          headers: {'content-type': 'application/json'});
    }
    return Response.ok(
        json.encode({"message": "Player is signed in", "token": token}),
        headers: {'content-type': 'application/json'});
  } catch (e) {
    print(e);
  }
  // refine later
  return Response(404);
}
