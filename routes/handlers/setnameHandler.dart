import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/playerrepository.dart';

Future<Response> setnameHandler(Request req) async {
  try {
    final requestbody = json.decode(await req.readAsString());
    if (requestbody["playername"] == null) {
      return Response.badRequest(
          body: json.encode({"message": "bad request body"}));
    }
    final updateddoc = await PlayerRepository.setName(
        playername: requestbody["playername"],
        id: req.context["_id"] as String);
    if (updateddoc == null) {
      return Response(404);
    }
    return Response.ok(json.encode({"message": "Player name changed"}),
        headers: {
          'content-type': 'application/json',
        });
  } catch (e) {
    print(e);
  }
  // refine later
  return Response(404);
}
