import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/authrepository.dart';

Future<Response> signinHandler(Request req) async {
  try {
    final requestbody = json.decode(await req.readAsString());
    final token = await Authrepository.signIn(
        email: requestbody["email"], password: requestbody["password"]);
    if (token != null) {
      final res = Response.ok(json.encode({"message": "Player is signed in"}),
          headers: {
            'Authorization': 'Bearer ${token}',
            'content-type': 'application/json',
          });
      print(res.headers);
      return res;
    } else {
      return Response.ok(json.encode({"message": "Cannot sign up the player"}),
          headers: {'content-type': 'application/json'});
    }
  } catch (e) {
    print(e);
  }
  // refine later
  return Response(404);
}
