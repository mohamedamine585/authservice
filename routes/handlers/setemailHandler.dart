import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/playerrepository.dart';

Future<Response> setemailHandler(Request req) async {
  try {
    final requestbody = json.decode(await req.readAsString());
    final updateddoc = await PlayerRepository.setEmail(
        email: requestbody["email"], id: req.context["_id"] as String);

    if (updateddoc == null) {
      return Response(404);
    }
    return Response.ok(json.encode({"message": "Player email changed"}),
        headers: {
          'content-type': 'application/json',
        });
  } catch (e) {
    print(e);
  }
  // refine later
  return Response(404);
}
