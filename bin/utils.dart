import 'package:crypt/crypt.dart';
import 'package:mongo_dart/mongo_dart.dart';

const dbname = 'TictactoeTest';
late final Db db;
String hashIT(String psw) {
  return Crypt.sha256(psw, salt: "salt&&&").hash;
}

late final DbCollection playerscollection;
late final DbCollection tokenscollection;
const SECRET_SAUCE = "7@SecretTliliSauce@7";
