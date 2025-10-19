import 'package:neurocare_app/features/call/data/models/call_model.dart';
import 'package:neurocare_app/features/call/domain/entities/call_entity.dart';

abstract class CallRemoteDataSource {
  /// Start a new call
  Future<CallModel> startCall({
    required String receiverId,
    required CallType callType,
  });

  /// End an ongoing call
  Future<CallModel> endCall(String callId);

  /// Get call history for current user
  Future<List<CallModel>> getCallHistory();

  /// Get ongoing call if any
  Future<CallModel?> getOngoingCall();

  /// Accept incoming call
  Future<CallModel> acceptCall(String callId);

  /// Decline incoming call
  Future<CallModel> declineCall(String callId);
}
