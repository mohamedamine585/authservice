import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../repositories/playerrepository.dart';

Future<Response> deleteAccountHandler(Request req) async {
  try {
    final deleted =
        await PlayerRepository.deleteAccount(id: req.context["_id"] as String);
    if (deleted) {
      return Response.ok(json.encode({"message": "deleted"}));
    } else {
      return Response.badRequest();
    }
  } catch (e) {
    print(e);
  }
  // refine later
  return Response(404);
}
