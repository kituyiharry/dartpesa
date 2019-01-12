/// Encapsulates error from a failed Lipa na M-Pesa transaction
class LNMError {
  final int resultCode;
  final String resultDesc;
  final String merchantRequestID;
  final String checkoutRequestID;

  LNMError(this.resultCode,this.resultDesc,this.merchantRequestID,this.checkoutRequestID);

  LNMError.fromJson(Map jsonData):
    resultCode = jsonData['ResultCode'],
    resultDesc = jsonData['ResultDesc'],
    merchantRequestID = jsonData['MerchantRequestID'],
    checkoutRequestID = jsonData['CheckoutRequestID'];
}

/// Encapsulates success of a successful Lipa na M-Pesa transaction
class LNMSuccess {
  final String merchantRequestID;
  final String checkoutRequestID;
  final int resultCode;
  final String resultDesc;

  LNMSuccess(this.merchantRequestID,this.checkoutRequestID,this.resultCode,this.resultDesc);
  LNMSuccess.fromJson(Map jsonData):
    resultCode = jsonData['ResultCode'],
    resultDesc = jsonData['ResultDesc'],
    merchantRequestID = jsonData['MerchantRequestID'],
    checkoutRequestID = jsonData['CheckoutRequestID'];
}
