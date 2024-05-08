import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/playerrepository.dart';

Future<Response> updatePlayer(Request req) async {
  try {
    final requestbody = json.decode(await req.readAsString());
    if (requestbody != null) {
      final id = req.context["_id"];

      if (id != null) {
        await PlayerRepository.updatePlayer(id: id as String, doc: requestbody);
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
