import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/playerrepository.dart';

Future<Response> getdocHandler(Request req) async {
  try {
    final doc = await PlayerRepository.getdoc(id: req.context["_id"] as String);
    if (doc?.isNotEmpty ?? false) {
      return Response.ok(json.encode({
        "playername": doc!["playername"],
        "email": doc["email"],
        "playedgames": doc["playedgames"],
        "wongames": doc["wongames"],
        "rating": doc["rating"],
        "country": doc["country"]
      }));
    } else {
      return Response.ok(
          json.encode({"message": "No doc found for this user"}));
    }
  } catch (e) {
    print(e);
  }

  // refine later
  return Response(404);
}
