import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_room_entity.dart';

abstract class ChatRepository {
  /// Get all chat rooms for the current user
  Future<Either<Failure, List<ChatRoomEntity>>> getChatRooms();

  /// Get chat room by ID
  Future<Either<Failure, ChatRoomEntity>> getChatRoomById(String chatRoomId);

  /// Get messages for a specific chat room
  Future<Either<Failure, List<ChatMessageEntity>>> getMessages(
    String chatRoomId, {
    int limit = 50,
    String? beforeMessageId,
  });

  /// Send a text message
  Future<Either<Failure, ChatMessageEntity>> sendMessage({
    required String chatRoomId,
    required String content,
  });

  /// Send an image message
  Future<Either<Failure, ChatMessageEntity>> sendImageMessage({
    required String chatRoomId,
    required String imagePath,
    String? caption,
  });

  /// Send a file message
  Future<Either<Failure, ChatMessageEntity>> sendFileMessage({
    required String chatRoomId,
    required String filePath,
    String? fileName,
  });

  /// Send a voice message
  Future<Either<Failure, ChatMessageEntity>> sendVoiceMessage({
    required String chatRoomId,
    required String audioPath,
    required int duration,
  });

  /// Mark messages as read
  Future<Either<Failure, void>> markMessagesAsRead(String chatRoomId);

  /// Create or get existing chat room with a participant
  Future<Either<Failure, ChatRoomEntity>> createOrGetChatRoom(
      String participantId);

  /// Delete a message (if allowed)
  Future<Either<Failure, void>> deleteMessage(String messageId);

  /// Start listening to real-time messages for a chat room
  Stream<ChatMessageEntity> listenToMessages(String chatRoomId);

  /// Start listening to chat room updates
  Stream<ChatRoomEntity> listenToChatRooms();
}
