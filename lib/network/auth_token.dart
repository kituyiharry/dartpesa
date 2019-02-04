import 'package:meta/meta.dart';

/// Encapsulates an Authentication token received from the Safaricom oauth server
class AuthToken {
  ///  [String] representation of OAUTH access token
  String accessToken;

  /// [DateTime] which the [accessToken] will become invalid
  DateTime expiresIn;

  AuthToken({@required this.accessToken, @required this.expiresIn})
      : assert(accessToken != null),
        assert(expiresIn != null);

  AuthToken.fromJson(Map jsonData)
      : accessToken = jsonData['access_token'],
        expiresIn = DateTime.now().add(
            Duration(seconds: int.parse(jsonData['expires_in'].toString())));

  bool isExpired() {
    return DateTime.now().isAfter(expiresIn);
  }

  @override
  String toString() {
    return "access_token: $accessToken, expires_at ${expiresIn.hour}:${expiresIn.minute}:${expiresIn.second}";
  }
}
