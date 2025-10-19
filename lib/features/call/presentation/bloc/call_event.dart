part of 'call_bloc.dart';

abstract class CallEvent {}

class StartCall extends CallEvent {
  final String receiverId;
  final CallType callType;

  StartCall({
    required this.receiverId,
    required this.callType,
  });
}

class EndCall extends CallEvent {
  final String callId;

  EndCall(this.callId);
}

class LoadCallHistory extends CallEvent {}
