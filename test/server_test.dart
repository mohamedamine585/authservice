import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements Client {}

void main() async {
  Process? process;
  final String baseUrl = 'http://0.0.0.0:8080';
  final String email =
      'test${DateTime.now().microsecondsSinceEpoch}@example.com';
  final String password = "password123";
  setUpAll(() async {
    final mockClient = MockClient();
    when(mockClient.head(Uri.parse(baseUrl))).thenAnswer(
        (_) => Future.value(Response('{"message": "success"}', 404)));

    // Start the server process
    process = await Process.start("dart", ["bin/server.dart"]);
  });

  group("Authentication testing", () {
    test('Signup Test', () async {
      final Uri signupUrl = Uri.parse('$baseUrl/signup');
      final Map<String, String> body = {'email': email, 'password': password};

      final Response response = await post(signupUrl, body: json.encode(body));

      expect(response.headers['content-type'], 'application/json');
      expect(response.headers['authorization'], isNotNull);
      expect(response.headers['authorization']!.startsWith('Bearer '), isTrue);
    });

    test('Signin Test', () async {
      final Uri signupUrl = Uri.parse('$baseUrl/signin');
      final Map<String, String> body = {'email': email, 'password': password};

      final Response response = await post(signupUrl, body: json.encode(body));

      expect(response.headers['content-type'], 'application/json');
      expect(response.headers['authorization'], isNotNull);
      expect(response.headers['authorization']!.startsWith('Bearer '), isTrue);
    });
  });

  // Terminate the server process
  tearDownAll(() async {
    process?.kill(ProcessSignal.sigkill);
    print('Server process terminated.');
  });
}
