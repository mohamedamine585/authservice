import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../repositories/authrepository.dart';
import '../../repositories/playerrepository.dart';

Future<Response> sendEmailVerification(Request req) async {
  try {
    final id = req.context["_id"];
    final doc = await PlayerRepository.getdoc(id: id as String);
    if (doc != null) {
      final email = doc["email"];
      if (email != null && (doc["isEmailVerified"] ?? false)) {
        final randomNumber =
            await Authrepository.sendEmailVerification(email: email);
        return Response.ok(json.encode({"random": randomNumber}));
      }
    }
  } catch (e) {
    print(e);
  }
  // refine later
  return Response(404);
}
