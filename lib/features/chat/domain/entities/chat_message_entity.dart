import 'package:equatable/equatable.dart';

enum MessageType { text, image, file, voice }

enum MessageStatus { sending, sent, delivered, read }

class ChatMessageEntity extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final MessageType type;
  final MessageStatus status;
  final DateTime timestamp;
  final String? fileUrl;
  final String? fileName;
  final int? fileSize;
  final String? thumbnailUrl;
  final bool isFromCurrentUser;

  const ChatMessageEntity({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.status,
    required this.timestamp,
    this.fileUrl,
    this.fileName,
    this.fileSize,
    this.thumbnailUrl,
    required this.isFromCurrentUser,
  });

  ChatMessageEntity copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? content,
    MessageType? type,
    MessageStatus? status,
    DateTime? timestamp,
    String? fileUrl,
    String? fileName,
    int? fileSize,
    String? thumbnailUrl,
    bool? isFromCurrentUser,
  }) {
    return ChatMessageEntity(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      isFromCurrentUser: isFromCurrentUser ?? this.isFromCurrentUser,
    );
  }

  bool get isTextMessage => type == MessageType.text;
  bool get isImageMessage => type == MessageType.image;
  bool get isFileMessage => type == MessageType.file;
  bool get isVoiceMessage => type == MessageType.voice;

  @override
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        content,
        type,
        status,
        timestamp,
        fileUrl,
        fileName,
        fileSize,
        thumbnailUrl,
        isFromCurrentUser,
      ];
}
