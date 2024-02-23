import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';

import '../repositories/tokenrepository.dart';

Middleware tokenizer() {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        Response response = await innerHandler(request);

        ObjectId id = ObjectId.fromHexString(request.context["_id"] as String);
        String? token = Tokenrepository.CreateJWToken(id);

        if (token != null) {
          token = await Tokenrepository.store_token(token: token, Id: id);
          final res = Response.ok(
              json.encode({"message": "Player is signed in"}),
              headers: {
                'Authorization': 'Bearer ${token}',
                'content-type': 'application/json',
              });
          return res;
        }
      } catch (e) {
        print(e);
      }
      return Response(404);
    };
  };
}
