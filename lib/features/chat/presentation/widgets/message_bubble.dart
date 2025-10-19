import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_message_entity.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessageEntity message;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isMe ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft:
                    isMe ? const Radius.circular(16) : const Radius.circular(4),
                bottomRight:
                    isMe ? const Radius.circular(4) : const Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message.content,
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 14,
                    color: isMe ? Colors.white : AppColors.primary,
                    height: 1.4,
                  ),
                  textAlign: isMe ? TextAlign.right : TextAlign.left,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 4, left: 4),
            child: Text(
              _formatMessageTime(message.timestamp),
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 10,
                color: AppColors.homeSecondaryText.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatMessageTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return 'أمس ${_formatTime(timestamp)}';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} يوم ${_formatTime(timestamp)}';
      } else {
        return '${timestamp.day}/${timestamp.month} ${_formatTime(timestamp)}';
      }
    } else {
      return _formatTime(timestamp);
    }
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
