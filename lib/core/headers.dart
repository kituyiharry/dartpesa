import 'dart:convert' as Convert;
import 'package:meta/meta.dart';

/// Wraps the ConsumerKey and ConsumerSecret provided by the Safaricom daraja apps, used to initialize the library too 
class Header {

  final String consumerSecret;
  final String consumerKey;
  final String authSecret;
  Header({@required this.consumerKey,@required this.consumerSecret}): 
    authSecret = Convert.base64Encode("$consumerKey:$consumerSecret".codeUnits);
  
}
