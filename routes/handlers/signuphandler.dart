import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../middleware/tokenizermidlleware.dart';
import '../../repositories/authrepository.dart';
import '../../repositories/tokenrepository.dart';

Future<Response> signupHandler(Request req) async {
  try {
    final requestbody = req.context["body"] as Map<String, dynamic>?;
    if (requestbody != null) {
      final id = await Authrepository.signUp(
          email: requestbody["email"], password: requestbody["password"]);

      if (id != null) {
        final token = Tokenrepository.CreateJWToken(id);
        return Response.ok(json.encode({"message": "Player signed up"}),
            headers: {
              'content-type': 'application/json',
              'Authorization': 'Bearer ${token}'
            });
      } else {
        return Response.ok(
            json.encode({"message": "Cannot sign up the player"}),
            headers: {
              'content-type': 'application/json',
            });
      }
    }
  } catch (e) {
    print(e);
  }
  // refine later
  return Response(404);
}
