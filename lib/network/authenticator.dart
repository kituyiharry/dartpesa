import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dartpesa/network/auth_token.dart';
import 'package:dartpesa/core/headers.dart';

const String authUrl = "sandbox.safaricom.co.ke";
const String authScheme = "https";
const String authPath = "/oauth/v1/generate";
const Map<String, String> authQueryParams = const <String, String>{
  'grant_type': 'client_credentials'
};

/// This receives an instance of [Header] and creates an authentication client that authenticates with Safaricoms
/// Authentication service. The received token is Parsed to Base64 to create an instance of [AuthToken] which is already
/// wrapped in a [Future] to support async programming patterns
class Authenticator {
  final Header _headers;
  final Uri authUri = Uri(
      scheme: authScheme,
      host: authUrl,
      path: authPath,
      queryParameters: authQueryParams);

  /// Constructor to instantiate [Authenticator] object
  Authenticator(this._headers);

  Future<AuthToken> fetchToken() async {
    AuthToken authToken;
    await http
        .get(authUri, headers: {
          "Authorization": "Basic ${_headers.authSecret}",
          "Content-Type": "application/json"
        })
        .then((response) => response.body)
        .then(jsonDecode)
        .then((jsonData) => AuthToken.fromJson(jsonData))
        .then((_at) {
          authToken = _at;
        });
    return authToken;
  }
}
