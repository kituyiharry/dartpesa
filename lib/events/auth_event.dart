import 'package:dartpesa/core/dpevent.dart';

class AuthEvent extends DPEvent {
  @override DPEventType getEventType() => DPEventType.AUTH_EVENT;
}

