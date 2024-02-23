import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../repositories/playerrepository.dart';

Future<Response> deleteaccountHandler(Request req) async {
  try {} catch (e) {
    print(e);
  }
  // refine later
  return Response(404);
}
