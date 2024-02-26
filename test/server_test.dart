import 'dart:io';
import 'package:test/test.dart';
import 'package:http/http.dart';

void main() {
  Process? process;
  setUpAll(() async {
    Map<String, String> env = Map.from(Platform.environment);
    env["DB"] = "TictactoeTest";

    process =
        await Process.start("dart", ["bin/server.dart"], environment: env);
    process?.stdout.listen((event) {
      print(event);
    });
  });

  final String baseUrl = 'http://0.0.0.0:8080';
  final String email =
      'test${DateTime.now().microsecondsSinceEpoch}@example.com';

  final String password = "password123";
  group("Authentication testing", () {
    test('Signup Test', () async {
      final Uri signupUrl = Uri.parse('$baseUrl/signup/');
      final Map<String, String> body = {'email': email, 'password': password};

      final Response response = await post(signupUrl, body: body);

      expect(response.statusCode, 200);
      expect(response.headers['content-type'], 'application/json');

      // Assuming the token is in the 'Authorization' header with the format 'Bearer <token>'
      expect(response.headers['authorization'], isNotNull);
      expect(response.headers['authorization']!.startsWith('Bearer '), isTrue);
    });

    test('Signin Test', () async {
      final Uri signinUrl = Uri.parse('$baseUrl/signin');
      final Map<String, String> body = {'email': email, 'password': password};

      final Response response = await post(signinUrl, body: body);

      expect(response.statusCode, 200);
      expect(response.headers['content-type'], 'application/json');

      // Assuming the token is in the 'Authorization' header with the format 'Bearer <token>'
      expect(response.headers['authorization'], isNotNull);
      expect(response.headers['authorization']!.startsWith('Bearer '), isTrue);
    });
  });
}
