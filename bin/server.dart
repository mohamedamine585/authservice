import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import '../middleware/queryfmiddleware.dart';
import '../routes/entry.dart';
import 'utils.dart';
import 'init.dart';

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;
// For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(queryfMiddleware()).addHandler(router);
  // init the db
  await Init.initDataBase();
  final server = await serve(handler, ip, port);

  print(
      'Server listening on address ${server.address.address} port ${server.port}');
}
