import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:neurocare_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:neurocare_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:neurocare_app/features/chat/presentation/widgets/chat_room_card.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(const LoadChatRooms());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'المحادثات',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColors.primary,
            ),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChatRoomsLoaded) {
            if (state.chatRooms.isEmpty) {
              return _buildEmptyState();
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.chatRooms.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ChatRoomCard(
                    chatRoom: state.chatRooms[index],
                    onTap: () => _navigateToChatDetail(state.chatRooms[index]),
                  ),
                );
              },
            );
          }

          if (state is ChatError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.homeSecondaryText,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ChatBloc>().add(const LoadChatRooms()),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar:
          const BottomNavBar(currentIndex: -1), // No active tab for chat
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: AppColors.homeSecondaryText.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد محادثات',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.homeSecondaryText,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'ابدأ محادثة مع طبيب من قائمة الأطباء',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.homeSecondaryText.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }

  void _navigateToChatDetail(chatRoom) {
    context.push(
      RouteNames.chatDetail,
      extra: chatRoom,
    );
  }
}
