import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/authrepository.dart';
import '../../repositories/tokenrepository.dart';

Future<Response> tictactoesigninHandler(Request req) async {
  try {
    final requestbody = req.context["body"] as Map<String, dynamic>?;
    if (requestbody != null) {
      List<int> tictactoe = [];
      (requestbody["tictactoe"] as List<dynamic>).forEach((element) {
        tictactoe.add(element);
      });
      final id = await Authrepository.setTictactoeSignIn(
          email: requestbody["email"], tictactoe: tictactoe);
      if (id != null) {
        final token = Tokenrepository.CreateJWToken(id);
        return Response.ok(json.encode({"message": "Player signed in"}),
            headers: {
              'content-type': 'application/json',
              'Authorization': 'Bearer ${token}'
            });
      } else {
        return Response.ok(
            json.encode({"message": "Cannot sign in the player"}),
            headers: {'content-type': 'application/json'});
      }
    }
  } catch (e) {
    print(e);
  }
  return Response(404);
}
