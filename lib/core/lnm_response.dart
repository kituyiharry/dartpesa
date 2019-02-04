/// A plain class that used by varying LNM Response Types
abstract class AbstractResponseType {}

/// Encapsulates a successful API call to the API after an [LNMOnlineTransaction] and carries immediate response information
/// from the result.
class LNMResponse extends AbstractResponseType {
  final String merchantRequestId;
  final String checkOutRequestId;
  final int responseCode;
  final int httpResCode;
  final String responseDescription;
  final String customerMessage;

  /// Constructs an [LNMResponse] object
  LNMResponse(this.merchantRequestId, this.checkOutRequestId, this.httpResCode,
      this.responseCode, this.responseDescription, this.customerMessage);

  /// Constructs an [LNMResponse] object from a Map of Json String along with the HTTP result code
  LNMResponse.fromJson(Map jsonData, this.httpResCode)
      : merchantRequestId = jsonData["MerchantRequestID"],
        checkOutRequestId = jsonData["CheckOutRequestID"],
        responseCode = int.parse(jsonData["ResponseCode"]),
        responseDescription = jsonData["ResponseDescription"],
        customerMessage = jsonData["CustomerMessage"];

  @override
  String toString() {
    return "$responseCode : $customerMessage";
  }
}

/// Encapsulates a Error from the API call to the API after an [LNMOnlineTransaction] and carries immediate response information
/// from the result.
class LNMError extends AbstractResponseType {
  final String requestId;
  final String errorCode;
  final String errorMessage;
  final int httpResCode;

  LNMError(this.requestId, this.httpResCode, this.errorCode, this.errorMessage);

  /// Constructs an [LNMError] object from a Map of Json String along with the HTTP result code
  LNMError.fromJson(Map jsonData, this.httpResCode)
      : requestId = jsonData["requestId"],
        errorCode = jsonData["errorCode"],
        errorMessage = jsonData["errorMessage"];

  @override
  String toString() => "$errorCode : $errorMessage [HTTP Code: $httpResCode]";
}
