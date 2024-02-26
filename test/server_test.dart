import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() async {
  final String baseUrl = 'http://localhost:8080';
  final String email =
      'test${DateTime.now().microsecondsSinceEpoch}@example.com';
  final String newEmail =
      'test${DateTime.now().microsecondsSinceEpoch}new@example.com';

  final String password = "password123";
  String token = "";

  group("Authentication testing", () {
    test('Signup Test', () async {
      final Uri signupUrl = Uri.parse('$baseUrl/signup');
      final Map<String, String> body = {
        'email': email,
        'password': "password123"
      };
      final http.Response response =
          await http.post(signupUrl, body: json.encode(body));

      expect(response.statusCode, 200);
      expect(response.headers['content-type'], 'application/json');
      expect(response.headers['authorization'], isNotNull);
      expect(response.headers['authorization']!.startsWith('Bearer '), isTrue);
    });
    test('Signin Test', () async {
      final Uri signupUrl = Uri.parse('$baseUrl/signin');
      final Map<String, String> body = {
        'email': email,
        'password': "password123"
      };
      final http.Response response =
          await http.post(signupUrl, body: json.encode(body));
      token = response.headers["authorization"] ?? "";

      expect(response.statusCode, 200);
      expect(response.headers['content-type'], 'application/json');
      expect(response.headers['authorization'], isNotNull);
      expect(response.headers['authorization']!.startsWith('Bearer '), isTrue);
    });
    test('SetName Test', () async {
      final Uri signupUrl = Uri.parse('$baseUrl/setname');
      final Map<String, String> body = {'name': 'name123'};
      final Map<String, String> headers = {'authorization': token};
      final http.Response response =
          await http.put(signupUrl, body: json.encode(body), headers: headers);

      expect(response.statusCode, 200);
      expect(json.decode(response.body), {"message": "Player name changed"});
      expect(response.headers['content-type'], 'application/json');
    });

    test('SetEmail Test', () async {
      final Uri signupUrl = Uri.parse('$baseUrl/setemail');
      final Map<String, String> body = {'email': newEmail};
      final Map<String, String> headers = {'authorization': token};
      final http.Response response =
          await http.put(signupUrl, body: json.encode(body), headers: headers);

      expect(response.statusCode, 200);
      expect(response.headers['content-type'], 'application/json');
      expect(json.decode(response.body), {"message": "Player email changed"});
    });
    test('Signin Test 2', () async {
      final Uri signupUrl = Uri.parse('$baseUrl/signin');
      final Map<String, String> body = {
        'email': newEmail,
        'password': "password123"
      };
      final http.Response response =
          await http.post(signupUrl, body: json.encode(body));

      expect(response.statusCode, 200);
      expect(response.headers['content-type'], 'application/json');
      expect(response.headers['authorization'], isNotNull);
      expect(response.headers['authorization']!.startsWith('Bearer '), isTrue);
    });
    // Add other tests as needed
  });
}
