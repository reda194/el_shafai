import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/exceptions.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_room_entity.dart';
import 'package:neurocare_app/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final String currentUserId =
      'current_user'; // In real app, get from auth service

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ChatRoomEntity>>> getChatRooms() async {
    try {
      final chatRooms = await remoteDataSource.getChatRooms(currentUserId);
      return Right(chatRooms);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, ChatRoomEntity>> getChatRoomById(
      String chatRoomId) async {
    try {
      final chatRoom =
          await remoteDataSource.getChatRoomById(chatRoomId, currentUserId);
      return Right(chatRoom);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getMessages(
    String chatRoomId, {
    int limit = 50,
    String? beforeMessageId,
  }) async {
    try {
      final messages = await remoteDataSource.getMessages(
        chatRoomId,
        currentUserId,
        limit: limit,
        beforeMessageId: beforeMessageId,
      );
      return Right(messages);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> sendMessage({
    required String chatRoomId,
    required String content,
  }) async {
    try {
      final message = await remoteDataSource.sendMessage(
        chatRoomId: chatRoomId,
        senderId: currentUserId,
        content: content,
      );
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> sendImageMessage({
    required String chatRoomId,
    required String imagePath,
    String? caption,
  }) async {
    // For now, simulate sending image message
    try {
      final content = caption ?? 'صورة';
      final message = await remoteDataSource.sendMessage(
        chatRoomId: chatRoomId,
        senderId: currentUserId,
        content: content,
      );
      // In real implementation, upload image first
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> sendFileMessage({
    required String chatRoomId,
    required String filePath,
    String? fileName,
  }) async {
    // For now, simulate sending file message
    try {
      final content = fileName ?? 'ملف';
      final message = await remoteDataSource.sendMessage(
        chatRoomId: chatRoomId,
        senderId: currentUserId,
        content: content,
      );
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> sendVoiceMessage({
    required String chatRoomId,
    required String audioPath,
    required int duration,
  }) async {
    // For now, simulate sending voice message
    try {
      final message = await remoteDataSource.sendMessage(
        chatRoomId: chatRoomId,
        senderId: currentUserId,
        content: 'رسالة صوتية (${duration}s)',
      );
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> markMessagesAsRead(String chatRoomId) async {
    try {
      await remoteDataSource.markMessagesAsRead(chatRoomId, currentUserId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, ChatRoomEntity>> createOrGetChatRoom(
      String participantId) async {
    try {
      final chatRoom = await remoteDataSource.createOrGetChatRoom(
          participantId, currentUserId);
      return Right(chatRoom);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(String messageId) async {
    // For now, simulate deletion
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Stream<ChatMessageEntity> listenToMessages(String chatRoomId) {
    return remoteDataSource.listenToMessages(chatRoomId, currentUserId);
  }

  @override
  Stream<ChatRoomEntity> listenToChatRooms() {
    return remoteDataSource.listenToChatRooms(currentUserId);
  }
}
