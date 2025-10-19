import 'package:equatable/equatable.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_message_entity.dart';

class ChatRoomEntity extends Equatable {
  final String id;
  final String participant1Id;
  final String participant1Name;
  final String participant1Avatar;
  final String participant2Id;
  final String participant2Name;
  final String participant2Avatar;
  final ChatMessageEntity? lastMessage;
  final int unreadCount;
  final DateTime lastActivity;
  final bool isActive;

  const ChatRoomEntity({
    required this.id,
    required this.participant1Id,
    required this.participant1Name,
    required this.participant1Avatar,
    required this.participant2Id,
    required this.participant2Name,
    required this.participant2Avatar,
    this.lastMessage,
    required this.unreadCount,
    required this.lastActivity,
    required this.isActive,
  });

  ChatRoomEntity copyWith({
    String? id,
    String? participant1Id,
    String? participant1Name,
    String? participant1Avatar,
    String? participant2Id,
    String? participant2Name,
    String? participant2Avatar,
    ChatMessageEntity? lastMessage,
    int? unreadCount,
    DateTime? lastActivity,
    bool? isActive,
  }) {
    return ChatRoomEntity(
      id: id ?? this.id,
      participant1Id: participant1Id ?? this.participant1Id,
      participant1Name: participant1Name ?? this.participant1Name,
      participant1Avatar: participant1Avatar ?? this.participant1Avatar,
      participant2Id: participant2Id ?? this.participant2Id,
      participant2Name: participant2Name ?? this.participant2Name,
      participant2Avatar: participant2Avatar ?? this.participant2Avatar,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      lastActivity: lastActivity ?? this.lastActivity,
      isActive: isActive ?? this.isActive,
    );
  }

  // Get the other participant's info (not current user)
  String get otherParticipantName =>
      participant2Name; // Assuming current user is participant1
  String get otherParticipantAvatar => participant2Avatar;
  String get otherParticipantId => participant2Id;

  String get lastMessagePreview {
    if (lastMessage == null) return '';
    if (lastMessage!.isTextMessage) {
      return lastMessage!.content.length > 50
          ? '${lastMessage!.content.substring(0, 50)}...'
          : lastMessage!.content;
    }
    return _getMessageTypeText(lastMessage!.type);
  }

  String _getMessageTypeText(MessageType type) {
    switch (type) {
      case MessageType.image:
        return 'صورة';
      case MessageType.file:
        return 'ملف';
      case MessageType.voice:
        return 'رسالة صوتية';
      default:
        return '';
    }
  }

  @override
  List<Object?> get props => [
        id,
        participant1Id,
        participant1Name,
        participant1Avatar,
        participant2Id,
        participant2Name,
        participant2Avatar,
        lastMessage,
        unreadCount,
        lastActivity,
        isActive,
      ];
}
