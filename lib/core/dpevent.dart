enum DPEventType {
  AUTH_EVENT,
  ERROR_EVENT,
  LNM_EVENT
}

abstract class DPEvent{
  DPEventType getEventType();
}
