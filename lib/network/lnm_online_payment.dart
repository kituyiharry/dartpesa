import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dartpesa/core/lnm_settings.dart';
import 'package:dartpesa/network/auth_token.dart';
import 'package:dartpesa/core/lnm_response.dart';

// Network calls to the LNM backend and returns a responseCode
class LNMOnlineTransaction {
  final LNMSettings lNMSettings;
  final Uri sTKPushUri;
  final AuthToken authToken;

  LNMOnlineTransaction(
      {@required this.lNMSettings,
      @required this.sTKPushUri,
      @required this.authToken})
      : assert(lNMSettings != null && sTKPushUri != null, authToken != null);

  Future<AbstractResponseType> transact() async {
    AbstractResponseType response;
    Map lnm = lNMSettings.asMap();
    await http
        .post(sTKPushUri,
            headers: {
              "Authorization": " Bearer ${authToken.accessToken}",
              "Content-Type": "application/json;charset=UTF-8"
            },
            body: jsonEncode(lnm))
        .then((res) {
      res.statusCode == 200
          ? response =
              LNMResponse.fromJson(jsonDecode(res.body), res.statusCode)
          : response = LNMError.fromJson(jsonDecode(res.body), res.statusCode);
    }).catchError((err) => print("Error: $err"));

    print(response.toString());
    return response;
  }
}
