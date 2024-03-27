import 'package:mongo_dart/mongo_dart.dart';

import 'package:test/expect.dart';
import 'dart:typed_data';

import '../bin/utils.dart';

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
    return null;
  }

  static Future<ObjectId?> tictactoeSignIn(
      {required String email, required List<int> tictactoe}) async {
    try {
      final hashedmatrix = hashMatrix(Uint8List.fromList(tictactoe));
      final Pdata = await playerscollection.findOne(
          where.eq("email", email).eq("tictactoe", hashedmatrix.bytes));
      if (Pdata?.isNotEmpty ?? false) {
        return Pdata!['_id'];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<ObjectId?> tictactoeSignUp(
      {required String email, required List<int> tictactoe}) async {
    try {
      final hashedmatrix = hashMatrix(Uint8List.fromList(tictactoe));
      final existing =
          await playerscollection.findOne(where.eq("email", email));
      if (existing?.isNotEmpty ?? false) {
        final doc = await playerscollection.updateOne(
            where.id(existing!["_id"]),
            modify.set("tictactoe", hashedmatrix.bytes));
        if (doc.isSuccess) {
          return existing["_id"] as ObjectId;
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
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
    return null;
  }
}
