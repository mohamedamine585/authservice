import 'package:shelf_router/shelf_router.dart';

import 'handlers/deleteaccounthandler.dart';
import 'handlers/getdochandler.dart';
import 'handlers/setemailHandler.dart';
import 'handlers/setnameHandler.dart';
import 'handlers/signinhandler.dart';
import 'handlers/signuphandler.dart';

// Configure routes.
Router router = Router()
  ..post('/signin', signinHandler)
  ..post('/signup', signupHandler)
  ..put('/setname', setnameHandler)
  ..put('/setemail', setemailHandler)
  ..get('/getdoc', getdocHandler)
  ..delete('/deleteaccount', deleteaccountHandler);
