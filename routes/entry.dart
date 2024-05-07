import 'package:shelf_router/shelf_router.dart';

import 'handlers/changetictactoesignup.dart';
import 'handlers/deleteaccounthandler.dart';
import 'handlers/getdochandler.dart';

import 'handlers/sendverification.dart';
import 'handlers/signinhandler.dart';
import 'handlers/signinwithtictactoe.dart';
import 'handlers/signuphandler.dart';
import 'handlers/signuptictactoe.dart';
import 'handlers/verifyemailhandler.dart';

// Configure routes.
Router router = Router()
  ..post('/signin', signinHandler)
  ..post('/signup', signupHandler)
  ..get('/verifyemail', sendEmailVerification)
  ..post('/verifyemail', verifyEmail)
  ..post('/tictactoein', tictactoesigninHandler)
  ..post('/tictactoe', tictactoesignupHandler)
  ..put('/tictactoe', tictactoechangeHandler)
  ..get('/getdoc', getdocHandler)
  ..delete('/delete', deleteAccountHandler);
