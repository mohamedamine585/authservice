import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';

import 'package:mongo_dart/mongo_dart.dart';

import 'dart:typed_data';

import '../bin/utils.dart';
import '../routes/utils.dart';

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

  static Future<ObjectId?> setTictactoeSignIn(
      {required String email, required List<int> tictactoe}) async {
    try {
      final hashedtictactoe = hashtictactoe(Uint8List.fromList(tictactoe));
      final Pdata = await playerscollection.findOne(
          where.eq("email", email).eq("tictactoe", hashedtictactoe.bytes));
      if (Pdata?.isNotEmpty ?? false) {
        return Pdata!['_id'];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<ObjectId?> changeTictactoeSignIn(
      {required String email,
      required List<int> oldtictactoe,
      required List<int> newtictactoe}) async {
    try {
      final hashedtictactoe = hashtictactoe(Uint8List.fromList(newtictactoe));
      final playerid = await setTictactoeSignIn(
          email: email,
          tictactoe: hashtictactoe(Uint8List.fromList(oldtictactoe)).bytes);
      if (playerid != null) {
        final Pdata = await playerscollection.updateOne(
            where.id(playerid), modify.set("tictactoe", hashedtictactoe.bytes));
        if (Pdata.isSuccess) {
          return Pdata.document!["_id"] as ObjectId;
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<ObjectId?> settictactoeSignUp(
      {required String email, required List<int> tictactoe}) async {
    try {
      final hashedtictactoe = hashtictactoe(Uint8List.fromList(tictactoe));
      final existing =
          await playerscollection.findOne(where.eq("email", email));
      if (existing?.isNotEmpty ?? false) {
        final doc = await playerscollection.updateOne(
            where.id(existing!["_id"]),
            modify.set("tictactoe", hashedtictactoe.bytes));
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

  static Future<int?> sendEmailVerification({required String email}) async {
    try {
      final vnumber = generateSixDigitRandomNumber();
      var response = await post(
        Uri.parse(mailjetUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ' + base64Encode(utf8.encode('$apiKey:$apiSecret')),
        },
        body: jsonEncode({
          'Messages': [
            {
              'Subject': 'Verification code XO game application',
              'From': {'Email': 'foxweb585@gmail.com'},
              'To': [
                {
                  'Email': email,
                }
              ],
              'HTMLPart':
                  '<h1>XO game app</h1><p>Hello, This is the verification code.</p> <h1> $vnumber</h1>',
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        print('Email sent successfully.');
        return int.parse(vnumber);
      } else {
        print('Failed to send email. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return null;
  }

  static Future<void> verifyemail({required ObjectId id}) async {
    try {
      await playerscollection.updateOne(
          where.id(id), modify.set("isEmailVerified", true));
    } catch (e) {
      print(e);
    }
  }
}

String generateSixDigitRandomNumber() {
  Random random = Random();
  int randomNumber = random.nextInt(900000) +
      100000; // Generates a random number between 100000 and 999999
  return randomNumber.toString();
}
