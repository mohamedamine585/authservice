import 'package:mongo_dart/mongo_dart.dart';

class Player {
  ObjectId id;
  String playername;
  String passwordhash;
  DateTime lastconnection;
  int playedgames, wongames;
  Player(this.id, this.playername, this.passwordhash, this.lastconnection,
      this.playedgames, this.wongames);
}
