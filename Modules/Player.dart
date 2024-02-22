import 'package:mongo_dart/mongo_dart.dart';

class Player {
  ObjectId id;
  String email;
  String? playername;
  String passwordhash;
  DateTime lastconnection;
  int playedgames, wongames;
  Player(this.id, this.email, this.passwordhash, this.lastconnection,
      this.playedgames, this.wongames);
}
