import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';

import '../../repositories/authrepository.dart';

Future<Response> verifyEmail(Request req) async {
  try {
    final id = req.context["_id"];
    if (id != null) {
      await Authrepository.verifyemail(
          id: ObjectId.fromHexString(id as String));
    }
  } catch (e) {
    print(e);
  }
  // refine later
  return Response(404);
}
