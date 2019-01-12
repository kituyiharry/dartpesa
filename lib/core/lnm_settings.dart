import 'package:meta/meta.dart';
import 'package:dartpesa/core/pass_key_param.dart';

// Encapsulates data required for a Lipa na M-Pesa transaction to complete
class LNMSettings {
  final int businessShortCode;
  final int amount;
  final int partyA;
  final int partyB;
  final int phoneNumber;
  final Uri callBackUrl;
  final String accountRef;
  final String transactionDesc;

  LNMSettings(
      {@required this.businessShortCode,
      @required this.amount,
      @required this.partyA,
      @required this.partyB,
      @required this.phoneNumber,
      @required this.callBackUrl,
      @required this.accountRef,
      @required this.transactionDesc})
      : assert(businessShortCode != null &&
            amount != null &&
            partyA != null &&
            partyB != null &&
            phoneNumber != null &&
            callBackUrl != null &&
            accountRef != null &&
            accountRef != null &&
            transactionDesc != null);

  Map<String, dynamic> asMap(String lnmKey) {
    DateTime ts = DateTime.now();
    String formattedTs =
        "${ts.year}${ts.month.toString().padLeft(2, '0')}${ts.day.toString().padLeft(2, '0')}${ts.hour.toString().padLeft(2, '0')}${ts.minute.toString().padLeft(2, '0')}${ts.second.toString().padLeft(2, '0')}";
    return {
      "BusinessShortCode": businessShortCode.toString(),
      "Password": PassKeyParam(businessShortCode, formattedTs, lnmKey)
          .createPassPhrase(),
      "Timestamp": formattedTs,
      "TransactionType": "CustomerPayBillOnline",
      "Amount": amount.toString(),
      "PartyA": partyA.toString(),
      "PartyB": partyB.toString(),
      "PhoneNumber": phoneNumber.toString(),
      "CallBackURL": callBackUrl.toString(),
      "AccountReference": accountRef,
      "TransactionDesc": transactionDesc
    };
  }
}
