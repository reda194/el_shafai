import 'package:equatable/equatable.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_room_entity.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatRoomsLoaded extends ChatState {
  final List<ChatRoomEntity> chatRooms;

  const ChatRoomsLoaded(this.chatRooms);

  @override
  List<Object> get props => [chatRooms];
}

class ChatRoomLoaded extends ChatState {
  final ChatRoomEntity chatRoom;

  const ChatRoomLoaded(this.chatRoom);

  @override
  List<Object> get props => [chatRoom];
}

class MessagesLoaded extends ChatState {
  final List<ChatMessageEntity> messages;

  const MessagesLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class MessageSent extends ChatState {
  final ChatMessageEntity message;

  const MessageSent(this.message);

  @override
  List<Object> get props => [message];
}

class MessagesMarkedAsRead extends ChatState {
  const MessagesMarkedAsRead();
}

class ChatRoomCreated extends ChatState {
  final ChatRoomEntity chatRoom;

  const ChatRoomCreated(this.chatRoom);

  @override
  List<Object> get props => [chatRoom];
}

class ChatListening extends ChatState {
  const ChatListening();
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object> get props => [message];
}
