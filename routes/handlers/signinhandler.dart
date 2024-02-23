import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/authrepository.dart';

Future<Response> signinHandler(Request req) async {
  try {
    final requestbody = await req.readAsString();
    final requestbodydecoded = json.decode(requestbody);
    if (requestbody != null) {
      final token = await Authrepository.signIn(
          email: requestbodydecoded["email"],
          password: requestbodydecoded["password"]);
      if (token != null) {
        final res = Response.ok(json.encode({"message": "Player is signed in"}),
            headers: {
              'Authorization': 'Bearer ${token}',
              'content-type': 'application/json',
            });
        return res;
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
