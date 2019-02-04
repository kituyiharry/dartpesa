import 'dart:convert';

/// Provides utilities to generate valid Lipa na M-Pesa Passphrase
class PassKeyParam {
  final int businessShortCode;
  final String timeStamp;
  final String lNMKey;

  PassKeyParam(this.businessShortCode, this.timeStamp, this.lNMKey);

  String createPassPhrase() {
    return base64Encode(
        "${businessShortCode.toString()}$lNMKey$timeStamp".codeUnits);
  }
}
