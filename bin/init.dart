import 'package:mongo_dart/mongo_dart.dart';

import 'utils.dart';

class Init {
  static initDataBase() async {
    try {
      db = await Db.create(
          "mongodb+srv://mohamedamine:medaminetlili123@cluster0.qf8cb49.mongodb.net/$dbname");
      await db.open();

      playerscollection = db.collection("players");
      tokenscollection = db.collection("tokens");
    } catch (e) {
      print(e);
    }
  }
}
