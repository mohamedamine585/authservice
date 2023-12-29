import 'package:shelf_router/shelf_router.dart';

import 'handlers/signinhandler.dart';
import 'handlers/signuphandler.dart';

// Configure routes.
Router router = Router()
  ..get('/Signin/', signinHandler)
  ..post('/Signup/', signupHandler);
