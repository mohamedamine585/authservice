import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:crypt/crypt.dart';

import 'package:mongo_dart/mongo_dart.dart';

final dbname = "TictactoeTest";
late final Db db;
String hashIT(String psw) {
  return Crypt.sha256(psw, salt: "salt&&&").hash;
}

Digest hashtictactoe(Uint8List tictactoeBytes) {
  return sha256.convert(tictactoeBytes);
}

late final DbCollection playerscollection;
late final DbCollection tokenscollection;
const SECRET_SAUCE = "7@SecretTliliSauce@7";
