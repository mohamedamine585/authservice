import 'package:mongo_dart/mongo_dart.dart';

import '../bin/utils.dart';

class PlayerRepository {
  static Future<Map<String, dynamic>?> setName(
      {required String playername, required String id}) async {
    try {
      final playerdoc = await playerscollection.findAndModify(
          query: where.id(ObjectId.fromHexString(id)),
          update: {"playername": playername});

      return playerdoc;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> setEmail(
      {required String email, required String id}) async {
    try {
      final playerdoc = await playerscollection.findAndModify(
          query: where.id(ObjectId.fromHexString(id)),
          update: {"email": email});

      return playerdoc;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
