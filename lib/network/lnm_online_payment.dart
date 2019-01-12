import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:dartpesa/core/lnm_settings.dart';
import 'package:dartpesa/network/auth_token.dart';
import 'package:dartpesa/core/lnm_response.dart';




class LNMOnlineTransaction{

  final LNMSettings lNMSettings;
  final Uri sTKPushUri;
  final AuthToken authToken; 

  LNMOnlineTransaction({@required this.lNMSettings,@required this.sTKPushUri,@required this.authToken}):
    assert(lNMSettings != null && sTKPushUri != null, authToken != null);


  Future<dynamic> transact(String lNMKey) async {
    //LNMSuccess lnmSuccess;
    //LNMError lnmError;
    Map lnm = lNMSettings.asMap(lNMKey);
    print(lnm);
    print("FlatMapping!!");
    print("AuthToken: ${authToken.accessToken}");
    await http.post(sTKPushUri,headers: {"Authorization": " Bearer ${authToken.accessToken}","Content-Type": "application/json;charset=UTF-8"},body: jsonEncode(lnm))
        .then((response) => print("Res: ${response.body}, ${response.statusCode}"))
        .catchError((err) => print("Error: $err"));
    return "RETURN";
  }

} 

