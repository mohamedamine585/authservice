import 'package:mongo_dart/mongo_dart.dart';

import '../bin/utils.dart';
import 'tokenrepository.dart';

class Authrepository {
  static Future<String?> signIn(
      {required String playername, required String password}) async {
    try {
      final Pdata = await playerscollection.findOne(
          where.eq("playername", playername).eq("password", hashIT(password)));
      Pdata!["lastconnection"] = DateTime.fromMicrosecondsSinceEpoch(
          (Pdata["lastconnection"] as Timestamp).seconds);
      String? token = Tokenrepository.CreateJWToken(Pdata["_id"]);
      if (token != null) {
        token =
            await Tokenrepository.store_token(token: token, Id: Pdata["_id"]);
      }

      return token;
    } catch (e) {
      print(e);
    }
  }

  static Future<WriteResult?> signUp(
      {required String playername, required String password}) async {
    try {
      final existing =
          await playerscollection.findOne(where.eq("playername", playername));
      if (existing?.isEmpty ?? true) {
        return await playerscollection.insertOne(
            {"playername": playername, "password": hashIT(password)});
      }
    } catch (e) {
      print(e);
    }
  }
}
