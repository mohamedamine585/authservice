import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import '../middleware/middlewarerouter.dart';
import '../middleware/authfmiddleware.dart';
import '../middleware/checktokenmiddleware.dart';
import '../middleware/tictactoeschema.dart';

import '../routes/entry.dart';
import 'init.dart';

void main(List<String> args) async {
  final ip = "0.0.0.0";
  final port = int.parse('8080');

  final handler = Pipeline()
      .addMiddleware(rootmiddleware())
      .addMiddleware(checktokenmiddleware())
      .addMiddleware(authMiddleware())
      .addMiddleware(tictactoeSchemaMiddleware())
      .addHandler(router);
  await Init.initDataBase();
  final server = await serve(handler, ip, port);

  print(
      'Server listening on address ${server.address.address} port ${server.port}');
}
