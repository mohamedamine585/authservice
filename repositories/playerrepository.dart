import 'package:mongo_dart/mongo_dart.dart';

import '../bin/utils.dart';

class PlayerRepository {
  static Future<Map<String, dynamic>?> setName(
      {required String playername, required String id}) async {
    try {
      final playerdoc = await playerscollection.findAndModify(
          query: where.id(ObjectId.fromHexString(id)),
          update: modify.set("playername", playername));

      return playerdoc;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
