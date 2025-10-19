part of 'call_bloc.dart';

abstract class CallState {}

class CallInitial extends CallState {}

class CallLoading extends CallState {}

class CallStarted extends CallState {
  final CallEntity call;

  CallStarted(this.call);
}

class CallEnded extends CallState {
  final CallEntity call;

  CallEnded(this.call);
}

class CallHistoryLoaded extends CallState {
  final List<CallEntity> calls;

  CallHistoryLoaded(this.calls);
}

class CallError extends CallState {
  final String message;

  CallError(this.message);
}
