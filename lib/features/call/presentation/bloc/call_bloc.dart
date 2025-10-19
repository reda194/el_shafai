import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/call/domain/entities/call_entity.dart';
import 'package:neurocare_app/features/call/domain/usecases/end_call_usecase.dart';
import 'package:neurocare_app/features/call/domain/usecases/get_call_history_usecase.dart';
import 'package:neurocare_app/features/call/domain/usecases/start_call_usecase.dart';

part 'call_event.dart';
part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final StartCallUseCase startCall;
  final EndCallUseCase endCall;
  final GetCallHistoryUseCase getCallHistory;

  CallBloc({
    required this.startCall,
    required this.endCall,
    required this.getCallHistory,
  }) : super(CallInitial()) {
    on<StartCall>(_onStartCall);
    on<EndCall>(_onEndCall);
    on<LoadCallHistory>(_onLoadCallHistory);
  }

  Future<void> _onStartCall(StartCall event, Emitter<CallState> emit) async {
    emit(CallLoading());
    final result = await startCall(StartCallParams(
      receiverId: event.receiverId,
      callType: event.callType,
    ));

    result.fold(
      (failure) => emit(CallError(failure.message)),
      (call) => emit(CallStarted(call)),
    );
  }

  Future<void> _onEndCall(EndCall event, Emitter<CallState> emit) async {
    emit(CallLoading());
    final result = await endCall(event.callId);

    result.fold(
      (failure) => emit(CallError(failure.message)),
      (call) => emit(CallEnded(call)),
    );
  }

  Future<void> _onLoadCallHistory(
    LoadCallHistory event,
    Emitter<CallState> emit,
  ) async {
    emit(CallLoading());
    final result = await getCallHistory(NoParams());

    result.fold(
      (failure) => emit(CallError(failure.message)),
      (calls) => emit(CallHistoryLoaded(calls)),
    );
  }
}
