import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_room_entity.dart';

class ChatRoomCard extends StatelessWidget {
  final ChatRoomEntity chatRoom;
  final VoidCallback onTap;

  const ChatRoomCard({
    super.key,
    required this.chatRoom,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(chatRoom.otherParticipantAvatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (chatRoom.unreadCount > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          chatRoom.unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 12),

            // Chat info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatRoom.otherParticipantName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.homePrimaryText,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chatRoom.lastMessagePreview,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.homeSecondaryText,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatTime(chatRoom.lastActivity),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.homeSecondaryText,
                      ),
                ),
                if (chatRoom.unreadCount > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return 'أمس';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} يوم';
      } else {
        return '${dateTime.day}/${dateTime.month}';
      }
    } else if (difference.inHours > 0) {
      return '${difference.inHours} س';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} د';
    } else {
      return 'الآن';
    }
  }
}
