import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/authrepository.dart';
import '../../repositories/tokenrepository.dart';

Future<Response> tictactoesignupHandler(Request req) async {
  try {
    final requestbody = json.decode(await req.readAsString());
    if (requestbody != null) {
      List<int> tictactoe = [];
      (requestbody["tictactoe"] as List<dynamic>).forEach((element) {
        tictactoe.add(element);
      });
      final id = await Authrepository.settictactoeSignUp(
          email: requestbody["email"], tictactoe: tictactoe);

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
