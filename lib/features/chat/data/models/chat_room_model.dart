import 'package:neurocare_app/features/chat/data/models/chat_message_model.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_room_entity.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_message_entity.dart';

class ChatRoomModel extends ChatRoomEntity {
  const ChatRoomModel({
    required super.id,
    required super.participant1Id,
    required super.participant1Name,
    required super.participant1Avatar,
    required super.participant2Id,
    required super.participant2Name,
    required super.participant2Avatar,
    super.lastMessage,
    required super.unreadCount,
    required super.lastActivity,
    required super.isActive,
  });

  factory ChatRoomModel.fromJson(
      Map<String, dynamic> json, String currentUserId) {
    return ChatRoomModel(
      id: json['id'] as String,
      participant1Id: json['participant1Id'] as String,
      participant1Name: json['participant1Name'] as String,
      participant1Avatar: json['participant1Avatar'] as String,
      participant2Id: json['participant2Id'] as String,
      participant2Name: json['participant2Name'] as String,
      participant2Avatar: json['participant2Avatar'] as String,
      lastMessage: json['lastMessage'] != null
          ? ChatMessageModel.fromJson(
              json['lastMessage'] as Map<String, dynamic>, currentUserId)
          : null,
      unreadCount: json['unreadCount'] as int,
      lastActivity: DateTime.parse(json['lastActivity'] as String),
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participant1Id': participant1Id,
      'participant1Name': participant1Name,
      'participant1Avatar': participant1Avatar,
      'participant2Id': participant2Id,
      'participant2Name': participant2Name,
      'participant2Avatar': participant2Avatar,
      'lastMessage': lastMessage != null
          ? ChatMessageModel.fromEntity(lastMessage!).toJson()
          : null,
      'unreadCount': unreadCount,
      'lastActivity': lastActivity.toIso8601String(),
      'isActive': isActive,
    };
  }

  // Factory for creating sample chat rooms
  factory ChatRoomModel.sample() {
    return ChatRoomModel(
      id: 'room_1',
      participant1Id: 'current_user',
      participant1Name: 'أنت',
      participant1Avatar: 'assets/images/user/avatar.jpg',
      participant2Id: 'doctor_123',
      participant2Name: 'د. سارة أحمد',
      participant2Avatar: 'assets/images/doctors/doctor_sara.png',
      lastMessage: ChatMessageModel.sampleIncoming(),
      unreadCount: 2,
      lastActivity: DateTime.now().subtract(const Duration(minutes: 3)),
      isActive: true,
    );
  }

  factory ChatRoomModel.sample2() {
    return ChatRoomModel(
      id: 'room_2',
      participant1Id: 'current_user',
      participant1Name: 'أنت',
      participant1Avatar: 'assets/images/user/avatar.jpg',
      participant2Id: 'doctor_456',
      participant2Name: 'د. محمد علي',
      participant2Avatar: 'assets/images/doctors/doctor_mohamed.png',
      lastMessage: ChatMessageModel(
        id: 'msg_old',
        senderId: 'doctor_456',
        receiverId: 'current_user',
        content: 'تذكر تناول أدويتك في موعدها',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isFromCurrentUser: false,
      ),
      unreadCount: 0,
      lastActivity: DateTime.now().subtract(const Duration(hours: 2)),
      isActive: true,
    );
  }
}
