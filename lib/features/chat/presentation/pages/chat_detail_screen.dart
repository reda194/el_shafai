import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_room_entity.dart';
import 'package:neurocare_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:neurocare_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:neurocare_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:neurocare_app/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:neurocare_app/features/chat/presentation/widgets/message_bubble.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatRoomEntity chatRoom;

  const ChatDetailScreen({
    super.key,
    required this.chatRoom,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessages(chatRoomId: widget.chatRoom.id));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage(String content) {
    context.read<ChatBloc>().add(
          SendMessage(
            chatRoomId: widget.chatRoom.id,
            content: content,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppAssets.arrowIcon,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            // Doctor Avatar
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(widget.chatRoom.otherParticipantAvatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Doctor Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.chatRoom.otherParticipantName,
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const Text(
                    'متصل الآن',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Call buttons
          IconButton(
            icon: const Icon(
              Icons.phone,
              color: AppColors.primary,
            ),
            onPressed: () => context.push(RouteNames.audioCall),
          ),
          IconButton(
            icon: const Icon(
              Icons.videocam,
              color: AppColors.primary,
            ),
            onPressed: () => context.push(RouteNames.videoCall),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is MessageSent) {
                  _scrollToBottom();
                }
              },
              builder: (context, state) {
                if (state is MessagesLoaded) {
                  if (state.messages.isEmpty) {
                    return _buildEmptyState();
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final isMe = message.senderId ==
                          'current_user'; // TODO: Get actual current user ID

                      return MessageBubble(
                        message: message,
                        isMe: isMe,
                      );
                    },
                  );
                }

                if (state is ChatLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ChatError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: const TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ChatBloc>().add(
                                  LoadMessages(chatRoomId: widget.chatRoom.id),
                                );
                          },
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),

          // Chat Input
          ChatInputField(
            onSendMessage: _sendMessage,
            isEnabled: true,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              color: AppColors.primary,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'ابدأ المحادثة',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'قم بإرسال رسالة لـ ${widget.chatRoom.otherParticipantName}',
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 14,
              color: AppColors.homeSecondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
