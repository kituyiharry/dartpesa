import 'dart:async';
import 'package:meta/meta.dart';
import 'package:dartpesa/core/headers.dart';
import 'package:dartpesa/core/lnm_settings.dart';
import 'package:dartpesa/core/lnm_response.dart';
import 'package:dartpesa/network/authenticator.dart';
import 'package:dartpesa/network/auth_token.dart';
import 'package:dartpesa/network/lnm_online_payment.dart';

/// GlobalBloc is the Business Logic Component for the package. It is composed of an [Authenticator] instance which handles authentication transactions
/// [StreamController]s control flow of data into relevant [Stream]s from [Sink]s which input the data. [LNMSettings] are created when a transaction needs
/// to be performed and either a [LNMError] or [LNMResponse] is returned depending on what the [LNMOnlineTransaction] returns when the call is made
class GlobalBloc {
  Authenticator _authenticator;
  Uri sTKPushUri = Uri(
      scheme: "https",
      host: "sandbox.safaricom.co.ke",
      path: "/mpesa/stkpush/v1/processrequest");

  final StreamController<LNMSettings> _lnmTransactionController =
      StreamController<LNMSettings>();
  final StreamController<AbstractResponseType> _responseController =
      StreamController<AbstractResponseType>();

  /// Listen for latest auth token
  Stream<AuthToken> auth = Stream.empty();

  /// Call to create an instance of LNMSettings when needed
  StreamSink<LNMSettings> get inLnm => _lnmTransactionController.sink;

  /// Listen internally for LNM Settings for transactions
  Stream<LNMSettings> get lnm => _lnmTransactionController.stream;

  /// Call internally to receive responses from LNM transactions
  StreamSink<AbstractResponseType> get _inRes => _responseController.sink;
  Stream<AbstractResponseType> get response => _responseController.stream;

  /// Constructor
  GlobalBloc({@required String consumerKey, @required String consumerSecret}) {
    assert(consumerKey.isNotEmpty && consumerSecret.isNotEmpty);
    _authenticator = Authenticator(
        Header(consumerKey: consumerKey, consumerSecret: consumerSecret));
    lnm.listen((LNMSettings lnm) {
      print("Authenticating!!");
      auth = _authenticator.fetchToken().asStream();
      auth.listen((authToken) {
        print("LNMTransaction");
        LNMOnlineTransaction transaction = LNMOnlineTransaction(
            sTKPushUri: sTKPushUri, lNMSettings: lnm, authToken: authToken);
        transaction.transact().then(_inRes.add).catchError((e) => print(e));
      });
    });
  }

  /// Called as an action to receive an [LNMSettings] and performs the [LNMOnlineTransaction] asynchronously
  void performTransaction(LNMSettings lNMSettings) async {
    inLnm.add(lNMSettings);
  }

  /// Make sure we close the [StreamController]s to prevent memory leaks
  void dispose() {
    _lnmTransactionController.close();
    _responseController.close();
  }
}
