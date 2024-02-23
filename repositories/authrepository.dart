import 'package:mongo_dart/mongo_dart.dart';

import '../bin/utils.dart';
import 'tokenrepository.dart';

class Authrepository {
  static Future<ObjectId?> signIn(
      {required String email, required String password}) async {
    try {
      final Pdata = await playerscollection
          .findOne(where.eq("email", email).eq("password", hashIT(password)));
      if (Pdata?.isNotEmpty ?? false) {
        return Pdata!['_id'];
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<ObjectId?> signUp(
      {required String email, required String password}) async {
    try {
      final existing =
          await playerscollection.findOne(where.eq("email", email));
      if (existing?.isEmpty ?? true) {
        final doc = await playerscollection
            .insertOne({"email": email, "password": hashIT(password)});

        if (doc.document != null) {
          return doc.document!["_id"] as ObjectId;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
