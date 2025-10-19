import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/features/chat/domain/usecases/get_chat_rooms_usecase.dart';
import 'package:neurocare_app/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:neurocare_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:neurocare_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:neurocare_app/features/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatRoomsUseCase getChatRooms;
  final GetMessagesUseCase getMessages;
  final SendMessageUseCase sendMessage;

  StreamSubscription? _messageSubscription;
  StreamSubscription? _chatRoomSubscription;

  ChatBloc({
    required this.getChatRooms,
    required this.getMessages,
    required this.sendMessage,
  }) : super(const ChatInitial()) {
    on<LoadChatRooms>(_onLoadChatRooms);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<StartListeningToMessages>(_onStartListeningToMessages);
    on<StopListeningToMessages>(_onStopListeningToMessages);
  }

  Future<void> _onLoadChatRooms(
    LoadChatRooms event,
    Emitter<ChatState> emit,
  ) async {
    emit(const ChatLoading());
    final result = await getChatRooms(const GetChatRoomsParams());
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (chatRooms) => emit(ChatRoomsLoaded(chatRooms)),
    );
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    final result = await getMessages(GetMessagesParams(
      chatRoomId: event.chatRoomId,
      limit: event.limit,
      beforeMessageId: event.beforeMessageId,
    ));
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (messages) => emit(MessagesLoaded(messages)),
    );
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    final result = await sendMessage(SendMessageParams(
      chatRoomId: event.chatRoomId,
      content: event.content,
    ));
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (message) => emit(MessageSent(message)),
    );
  }

  Future<void> _onStartListeningToMessages(
    StartListeningToMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(const ChatListening());

    // Cancel existing subscriptions
    await _messageSubscription?.cancel();

    // In a real implementation, you would listen to the repository's stream
    // For now, we'll just emit a listening state
  }

  Future<void> _onStopListeningToMessages(
    StopListeningToMessages event,
    Emitter<ChatState> emit,
  ) async {
    await _messageSubscription?.cancel();
    await _chatRoomSubscription?.cancel();
    emit(const ChatInitial());
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _chatRoomSubscription?.cancel();
    return super.close();
  }
}
