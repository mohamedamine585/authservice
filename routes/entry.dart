import 'package:shelf_router/shelf_router.dart';

import 'handlers/roothandler.dart';
import 'handlers/signinhandler.dart';
import 'handlers/signuphandler.dart';

// Configure routes.
Router router = Router()..post('/signin', signinHandler);
