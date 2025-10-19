import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:neurocare_app/features/chat/domain/repositories/chat_repository.dart';

class GetMessagesUseCase
    implements UseCase<List<ChatMessageEntity>, GetMessagesParams> {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> call(
      GetMessagesParams params) {
    return repository.getMessages(
      params.chatRoomId,
      limit: params.limit,
      beforeMessageId: params.beforeMessageId,
    );
  }
}

class GetMessagesParams extends Equatable {
  final String chatRoomId;
  final int limit;
  final String? beforeMessageId;

  const GetMessagesParams({
    required this.chatRoomId,
    this.limit = 50,
    this.beforeMessageId,
  });

  @override
  List<Object?> get props => [chatRoomId, limit, beforeMessageId];
}
