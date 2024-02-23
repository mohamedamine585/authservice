import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/authrepository.dart';
import '../../repositories/tokenrepository.dart';

Future<Response> signinHandler(Request req) async {
  try {
    final requestbody = req.context["body"] as Map<String, dynamic>?;
    if (requestbody != null) {
      final id = await Authrepository.signIn(
          email: requestbody["email"], password: requestbody["password"]);
      if (id != null) {
        final token = Tokenrepository.CreateJWToken(id);
        return Response.ok(json.encode({"message": "Player signed in"}),
            headers: {
              'content-type': 'application/json',
              'Authorization': 'Bearer ${token}'
            });
      } else {
        return Response.ok(
            json.encode({"message": "Cannot sign up the player"}),
            headers: {'content-type': 'application/json'});
      }
    }
  } catch (e) {
    print(e);
  }
  return Response(404);
}
