import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/authrepository.dart';

Future<Response> signupHandler(Request req) async {
  try {
    final requestbody = json.decode(await req.readAsString());
    final token = await Authrepository.signUp(
        email: requestbody["email"], password: requestbody["password"]);
    if (token != null) {
      return Response.ok(json.encode({"message": "Player is signed up"}),
          headers: {
            'content-type': 'application/json',
            'Authorization': "Bearer ${token}"
          });
    } else {
      return Response.ok(json.encode({"message": "Cannot sign up the player"}),
          headers: {
            'content-type': 'application/json',
          });
    }
  } catch (e) {
    print(e);
  }
  // refine later
  return Response(404);
}
