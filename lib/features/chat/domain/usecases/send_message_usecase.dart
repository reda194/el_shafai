import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:neurocare_app/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUseCase
    implements UseCase<ChatMessageEntity, SendMessageParams> {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, ChatMessageEntity>> call(SendMessageParams params) {
    return repository.sendMessage(
      chatRoomId: params.chatRoomId,
      content: params.content,
    );
  }
}

class SendMessageParams extends Equatable {
  final String chatRoomId;
  final String content;

  const SendMessageParams({
    required this.chatRoomId,
    required this.content,
  });

  @override
  List<Object?> get props => [chatRoomId, content];
}
