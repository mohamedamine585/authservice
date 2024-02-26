import 'package:mongo_dart/mongo_dart.dart';

import '../bin/utils.dart';

class PlayerRepository {
  static Future<Map<String, dynamic>?> setName(
      {required String playername, required String id}) async {
    try {
      final existingDoc =
          await playerscollection.findOne(where.id(ObjectId.fromHexString(id)));

      if (existingDoc != null) {
        // Extract the existing "password" field value
        final existingPassword = existingDoc['password'];
        final existingEmail = existingDoc['email'];

        // Perform the update, including the existing "password" value
        final playerdoc = await playerscollection.update(
          where.id(ObjectId.fromHexString(id)),
          {
            "name": playername,
            "email": existingEmail,
            "password":
                existingPassword, // Include the existing password in the update
          },
        );
        return playerdoc;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> setEmail(
      {required String email, required String id}) async {
    try {
      final existingDoc =
          await playerscollection.findOne(where.id(ObjectId.fromHexString(id)));

      if (existingDoc != null) {
        // Extract the existing "password" field value
        final existingPassword = existingDoc['password'];

        // Perform the update, including the existing "password" value
        final playerdoc = await playerscollection.update(
          where.id(ObjectId.fromHexString(id)),
          {
            "email": email,
            "password":
                existingPassword, // Include the existing password in the update
          },
        );
        return playerdoc;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> getdoc({required String id}) async {
    try {
      final playerdoc =
          await playerscollection.findOne(where.id(ObjectId.fromHexString(id)));

      return playerdoc;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
