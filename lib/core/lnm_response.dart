// LNMResponse Encapsulates responseCode from the API, callback response code is different
abstract class AbstractResponseType{}

class LNMResponse extends AbstractResponseType{

  final String merchantRequestId;
  final String checkOutRequestId;
  final int responseCode;
  final int httpResCode;
  final String responseDescription;
  final String customerMessage;

  LNMResponse(this.merchantRequestId,this.checkOutRequestId,this.httpResCode,this.responseCode,this.responseDescription,this.customerMessage);
  
  LNMResponse.fromJson(Map jsonData,this.httpResCode): 
    merchantRequestId = jsonData["MerchantRequestID"],
    checkOutRequestId = jsonData["CheckOutRequestID"],
    responseCode = int.parse(jsonData["ResponseCode"]),
    responseDescription = jsonData["ResponseDescription"],
    customerMessage = jsonData["CustomerMessage"];

    @override
    String toString(){
      return "$responseCode : $customerMessage";
    }
}

class LNMError extends AbstractResponseType{

  final String requestId;
  final String errorCode;
  final String errorMessage;
  final int httpResCode;

  LNMError(this.requestId,this.httpResCode,this.errorCode,this.errorMessage);

  LNMError.fromJson(Map jsonData,this.httpResCode): 
    requestId = jsonData["requestId"],
    errorCode = jsonData["errorCode"],
    errorMessage = jsonData["errorMessage"];

  @override 
  String toString() => "$errorCode : $errorMessage [HTTP Code: $httpResCode]";  

}
