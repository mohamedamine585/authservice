import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/authrepository.dart';

Future<Response> signupHandler(Request req) async {
  try {
    final requestbody = json.decode(await req.readAsString());
    final wresult = await Authrepository.signUp(
        email: requestbody["email"], password: requestbody["password"]);
    if (wresult?.isSuccess ?? false) {
      return Response.ok(json.encode({"message": "Player is signed up"}),
          headers: {'content-type': 'application/json'});
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
