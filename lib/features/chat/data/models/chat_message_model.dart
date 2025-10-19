import 'package:neurocare_app/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    required super.content,
    required super.type,
    required super.status,
    required super.timestamp,
    super.fileUrl,
    super.fileName,
    super.fileSize,
    super.thumbnailUrl,
    required super.isFromCurrentUser,
  });

  factory ChatMessageModel.fromJson(
      Map<String, dynamic> json, String currentUserId) {
    return ChatMessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      content: json['content'] as String,
      type: _parseMessageType(json['type'] as String),
      status: _parseMessageStatus(json['status'] as String),
      timestamp: DateTime.parse(json['timestamp'] as String),
      fileUrl: json['fileUrl'] as String?,
      fileName: json['fileName'] as String?,
      fileSize: json['fileSize'] as int?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      isFromCurrentUser: json['senderId'] == currentUserId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'fileUrl': fileUrl,
      'fileName': fileName,
      'fileSize': fileSize,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  static MessageType _parseMessageType(String type) {
    switch (type.toLowerCase()) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'file':
        return MessageType.file;
      case 'voice':
        return MessageType.voice;
      default:
        return MessageType.text;
    }
  }

  static MessageStatus _parseMessageStatus(String status) {
    switch (status.toLowerCase()) {
      case 'sending':
        return MessageStatus.sending;
      case 'sent':
        return MessageStatus.sent;
      case 'delivered':
        return MessageStatus.delivered;
      case 'read':
        return MessageStatus.read;
      default:
        return MessageStatus.sent;
    }
  }

  // Factory for creating sample messages
  factory ChatMessageModel.sampleOutgoing() {
    return ChatMessageModel(
      id: 'msg_1',
      senderId: 'current_user',
      receiverId: 'doctor_123',
      content: 'مرحباً دكتور، كيف حالك؟',
      type: MessageType.text,
      status: MessageStatus.sent,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isFromCurrentUser: true,
    );
  }

  factory ChatMessageModel.sampleIncoming() {
    return ChatMessageModel(
      id: 'msg_2',
      senderId: 'doctor_123',
      receiverId: 'current_user',
      content: 'مرحباً! أنا بخير شكراً لك. كيف يمكنني مساعدتك؟',
      type: MessageType.text,
      status: MessageStatus.read,
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      isFromCurrentUser: false,
    );
  }

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel(
      id: entity.id,
      senderId: entity.senderId,
      receiverId: entity.receiverId,
      content: entity.content,
      type: entity.type,
      status: entity.status,
      timestamp: entity.timestamp,
      fileUrl: entity.fileUrl,
      fileName: entity.fileName,
      fileSize: entity.fileSize,
      thumbnailUrl: entity.thumbnailUrl,
      isFromCurrentUser: entity.isFromCurrentUser,
    );
  }

  factory ChatMessageModel.sampleImage() {
    return ChatMessageModel(
      id: 'msg_3',
      senderId: 'current_user',
      receiverId: 'doctor_123',
      content: 'إليك صورة الأشعة',
      type: MessageType.image,
      status: MessageStatus.delivered,
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
      fileUrl: 'https://example.com/xray.jpg',
      fileName: 'xray.jpg',
      thumbnailUrl: 'https://example.com/xray_thumb.jpg',
      isFromCurrentUser: true,
    );
  }
}
