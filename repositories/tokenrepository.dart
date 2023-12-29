import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../bin/utils.dart';

class Tokenrepository {
  @override
  static Future<void> make_available_token(String token) async {
    try {
      await tokenscollection.update(
          where.eq("token", token), modify.set("inuse", false),
          multiUpdate: true);
    } catch (e) {
      print(e);
    }
  }

  @override
  static Future<String?> store_token(
      {required String token, required ObjectId Id}) async {
    try {
      final existing = await tokenscollection.findOne(where.eq("_id", Id));
      if (existing != null && existing.isNotEmpty && !existing["inuse"]) {
        await tokenscollection
            .update(where.id(Id), {"token": token, "inuse": false});
        return token;
      } else if (existing?.isEmpty ?? true) {
        await tokenscollection
            .insertOne({"_id": Id, "token": token, "inuse": false});
        return token;
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  static Future<bool?> delete_token({required ObjectId id}) async {
    try {
      final existing = await tokenscollection.findOne(where.eq("_id", id));
      if (existing != null && existing.isNotEmpty) {
        final res = await tokenscollection.deleteOne(where.eq("_id", id));
        return res.isSuccess;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  static Future<String?> change_token_status(ObjectId id) async {
    try {
      final doc = await tokenscollection.findOne(where.id(id));
      if (doc != null) {
        await tokenscollection.update(
            where.id(doc["_id"]), modify.set("inuse", !(doc["inuse"])));
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static String? CreateJWToken(ObjectId Playerid) {
    try {
      final jwt = JWT(
        {
          'playerid': Playerid,
        },
        issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
      );

      return jwt.sign(SecretKey(SECRET_SAUCE));
    } catch (e) {
      print("Problem to create jwt token");
    }
    return null;
  }
}
