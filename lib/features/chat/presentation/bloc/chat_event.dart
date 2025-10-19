import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChatRooms extends ChatEvent {
  const LoadChatRooms();
}

class LoadChatRoom extends ChatEvent {
  final String chatRoomId;

  const LoadChatRoom(this.chatRoomId);

  @override
  List<Object> get props => [chatRoomId];
}

class LoadMessages extends ChatEvent {
  final String chatRoomId;
  final int limit;
  final String? beforeMessageId;

  const LoadMessages({
    required this.chatRoomId,
    this.limit = 50,
    this.beforeMessageId,
  });

  @override
  List<Object?> get props => [chatRoomId, limit, beforeMessageId];
}

class SendMessage extends ChatEvent {
  final String chatRoomId;
  final String content;

  const SendMessage({
    required this.chatRoomId,
    required this.content,
  });

  @override
  List<Object> get props => [chatRoomId, content];
}

class SendImageMessage extends ChatEvent {
  final String chatRoomId;
  final String imagePath;
  final String? caption;

  const SendImageMessage({
    required this.chatRoomId,
    required this.imagePath,
    this.caption,
  });

  @override
  List<Object?> get props => [chatRoomId, imagePath, caption];
}

class SendFileMessage extends ChatEvent {
  final String chatRoomId;
  final String filePath;
  final String? fileName;

  const SendFileMessage({
    required this.chatRoomId,
    required this.filePath,
    this.fileName,
  });

  @override
  List<Object?> get props => [chatRoomId, filePath, fileName];
}

class SendVoiceMessage extends ChatEvent {
  final String chatRoomId;
  final String audioPath;
  final int duration;

  const SendVoiceMessage({
    required this.chatRoomId,
    required this.audioPath,
    required this.duration,
  });

  @override
  List<Object> get props => [chatRoomId, audioPath, duration];
}

class MarkMessagesAsRead extends ChatEvent {
  final String chatRoomId;

  const MarkMessagesAsRead(this.chatRoomId);

  @override
  List<Object> get props => [chatRoomId];
}

class CreateOrGetChatRoom extends ChatEvent {
  final String participantId;

  const CreateOrGetChatRoom(this.participantId);

  @override
  List<Object> get props => [participantId];
}

class StartListeningToMessages extends ChatEvent {
  final String chatRoomId;

  const StartListeningToMessages(this.chatRoomId);

  @override
  List<Object> get props => [chatRoomId];
}

class StopListeningToMessages extends ChatEvent {
  const StopListeningToMessages();
}
