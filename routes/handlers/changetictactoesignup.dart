import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/authrepository.dart';
import '../../repositories/tokenrepository.dart';

Future<Response> tictactoechangeHandler(Request req) async {
  try {
    final requestbody = req.context["body"] as Map<String, dynamic>?;
    if (requestbody != null) {
      List<int> newtictactoe = [];
      (requestbody["newtictactoe"] as List<dynamic>).forEach((element) {
        newtictactoe.add(element);
      });
      List<int> oldtictactoe = [];
      (requestbody["oldtictactoe"] as List<dynamic>).forEach((element) {
        oldtictactoe.add(element);
      });
      final id = await Authrepository.changeTictactoeSignIn(
          email: requestbody["email"],
          newtictactoe: newtictactoe,
          oldtictactoe: oldtictactoe);

      if (id != null) {
        final token = Tokenrepository.CreateJWToken(id);
        return Response.ok(json.encode({"message": "Tictactoe schema added"}),
            headers: {
              'content-type': 'application/json',
              'Authorization': 'Bearer ${token}'
            });
      } else {
        return Response.ok(
            json.encode({"message": "Cannot add tictactoe schema"}),
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
