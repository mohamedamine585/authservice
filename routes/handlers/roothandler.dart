import 'dart:io';

import 'package:shelf/shelf.dart';

Future<Response> roothandler(Request request) async {
  File loginfile = File('C:/Users/foxwe/authserver/public/login2.html');
  return Response.ok(
    loginfile.readAsStringSync(),
    headers: {'Content-Type': 'text/html'},
  );
}
