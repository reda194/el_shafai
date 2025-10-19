import 'dart:async';
import 'package:neurocare_app/features/chat/data/models/chat_message_model.dart';
import 'package:neurocare_app/features/chat/data/models/chat_room_model.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_message_entity.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatRoomModel>> getChatRooms(String currentUserId);
  Future<ChatRoomModel> getChatRoomById(
      String chatRoomId, String currentUserId);
  Future<List<ChatMessageModel>> getMessages(
    String chatRoomId,
    String currentUserId, {
    int limit = 50,
    String? beforeMessageId,
  });
  Future<ChatMessageModel> sendMessage({
    required String chatRoomId,
    required String senderId,
    required String content,
  });
  Future<void> markMessagesAsRead(String chatRoomId, String userId);
  Future<ChatRoomModel> createOrGetChatRoom(
      String participantId, String currentUserId);
  Stream<ChatMessageModel> listenToMessages(
      String chatRoomId, String currentUserId);
  Stream<ChatRoomModel> listenToChatRooms(String currentUserId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  // Simulate in-memory storage
  final Map<String, List<ChatMessageModel>> _messages = {};
  final Map<String, ChatRoomModel> _chatRooms = {};
  final StreamController<ChatMessageModel> _messageController =
      StreamController.broadcast();
  final StreamController<ChatRoomModel> _chatRoomController =
      StreamController.broadcast();

  ChatRemoteDataSourceImpl() {
    // Initialize with sample data
    _initializeSampleData();
  }

  void _initializeSampleData() {
    // Create sample chat rooms
    final room1 = ChatRoomModel.sample();
    final room2 = ChatRoomModel.sample2();

    _chatRooms[room1.id] = room1;
    _chatRooms[room2.id] = room2;

    // Create sample messages for room1
    _messages[room1.id] = [
      ChatMessageModel.sampleOutgoing(),
      ChatMessageModel.sampleIncoming(),
      ChatMessageModel.sampleImage(),
    ];

    // Create sample messages for room2
    _messages[room2.id] = [
      ChatMessageModel(
        id: 'msg_old_1',
        senderId: 'current_user',
        receiverId: 'doctor_456',
        content: 'شكراً دكتور على النصيحة',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isFromCurrentUser: true,
      ),
      ChatMessageModel(
        id: 'msg_old_2',
        senderId: 'doctor_456',
        receiverId: 'current_user',
        content: 'تذكر تناول أدويتك في موعدها',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isFromCurrentUser: false,
      ),
    ];
  }

  @override
  Future<List<ChatRoomModel>> getChatRooms(String currentUserId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _chatRooms.values.toList();
  }

  @override
  Future<ChatRoomModel> getChatRoomById(
      String chatRoomId, String currentUserId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final room = _chatRooms[chatRoomId];
    if (room == null) {
      throw Exception('Chat room not found');
    }
    return room;
  }

  @override
  Future<List<ChatMessageModel>> getMessages(
    String chatRoomId,
    String currentUserId, {
    int limit = 50,
    String? beforeMessageId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final messages = _messages[chatRoomId] ?? [];
    return messages.take(limit).toList();
  }

  @override
  Future<ChatMessageModel> sendMessage({
    required String chatRoomId,
    required String senderId,
    required String content,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final newMessage = ChatMessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderId: senderId,
      receiverId: _chatRooms[chatRoomId]!.participant2Id,
      content: content,
      type: MessageType.text,
      status: MessageStatus.sent,
      timestamp: DateTime.now(),
      isFromCurrentUser: true,
    );

    // Add to messages
    if (_messages[chatRoomId] == null) {
      _messages[chatRoomId] = [];
    }
    _messages[chatRoomId]!.add(newMessage);

    // Update chat room last message
    final room = _chatRooms[chatRoomId]!;
    _chatRooms[chatRoomId] = ChatRoomModel(
      id: room.id,
      participant1Id: room.participant1Id,
      participant1Name: room.participant1Name,
      participant1Avatar: room.participant1Avatar,
      participant2Id: room.participant2Id,
      participant2Name: room.participant2Name,
      participant2Avatar: room.participant2Avatar,
      lastMessage: newMessage,
      unreadCount: room.unreadCount,
      lastActivity: DateTime.now(),
      isActive: room.isActive,
    );

    // Emit to stream
    _messageController.add(newMessage);
    _chatRoomController.add(_chatRooms[chatRoomId]!);

    return newMessage;
  }

  @override
  Future<void> markMessagesAsRead(String chatRoomId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final room = _chatRooms[chatRoomId];
    if (room != null) {
      _chatRooms[chatRoomId] = ChatRoomModel(
        id: room.id,
        participant1Id: room.participant1Id,
        participant1Name: room.participant1Name,
        participant1Avatar: room.participant1Avatar,
        participant2Id: room.participant2Id,
        participant2Name: room.participant2Name,
        participant2Avatar: room.participant2Avatar,
        lastMessage: room.lastMessage,
        unreadCount: 0,
        lastActivity: room.lastActivity,
        isActive: room.isActive,
      );
      _chatRoomController.add(_chatRooms[chatRoomId]!);
    }
  }

  @override
  Future<ChatRoomModel> createOrGetChatRoom(
      String participantId, String currentUserId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Check if room already exists
    final existingRoom = _chatRooms.values.firstWhere(
      (room) => room.participant2Id == participantId,
      orElse: () => ChatRoomModel(
        id: '',
        participant1Id: currentUserId,
        participant1Name: 'أنت',
        participant1Avatar: 'assets/images/user/avatar.jpg',
        participant2Id: participantId,
        participant2Name: 'دكتور', // This would be fetched from user service
        participant2Avatar: 'assets/images/doctors/doctor.png',
        unreadCount: 0,
        lastActivity: DateTime.now(),
        isActive: true,
      ),
    );

    if (existingRoom.id.isNotEmpty) {
      return existingRoom;
    }

    // Create new room
    final newRoomId = 'room_${DateTime.now().millisecondsSinceEpoch}';
    final newRoom = ChatRoomModel(
      id: newRoomId,
      participant1Id: currentUserId,
      participant1Name: 'أنت',
      participant1Avatar: 'assets/images/user/avatar.jpg',
      participant2Id: participantId,
      participant2Name: 'دكتور جديد',
      participant2Avatar: 'assets/images/doctors/doctor.png',
      unreadCount: 0,
      lastActivity: DateTime.now(),
      isActive: true,
    );

    _chatRooms[newRoomId] = newRoom;
    _messages[newRoomId] = [];

    return newRoom;
  }

  @override
  Stream<ChatMessageModel> listenToMessages(
      String chatRoomId, String currentUserId) {
    return _messageController.stream.where((message) =>
        message.receiverId == currentUserId ||
        message.senderId == currentUserId);
  }

  @override
  Stream<ChatRoomModel> listenToChatRooms(String currentUserId) {
    return _chatRoomController.stream;
  }
}
