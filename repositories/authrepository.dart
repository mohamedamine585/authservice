import 'package:mongo_dart/mongo_dart.dart';

import '../bin/utils.dart';
import 'tokenrepository.dart';

class Authrepository {
  static Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      final Pdata = await playerscollection
          .findOne(where.eq("email", email).eq("password", hashIT(password)));
      if (Pdata?.isNotEmpty ?? false) {
        String? token = Tokenrepository.CreateJWToken(Pdata!["_id"]);
        if (token != null) {
          token =
              await Tokenrepository.store_token(token: token, Id: Pdata["_id"]);
          return token;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      final existing =
          await playerscollection.findOne(where.eq("email", email));
      if (existing?.isEmpty ?? true) {
        final doc = await playerscollection
            .insertOne({"email": email, "password": hashIT(password)});
        if (doc.document != null) {
          String? token = Tokenrepository.CreateJWToken(
              (doc.document as Map<String, dynamic>)["_id"]);
          if (token != null) {
            token = await Tokenrepository.store_token(
                token: token,
                Id: (doc.document as Map<String, dynamic>)["_id"]);
            return token;
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
