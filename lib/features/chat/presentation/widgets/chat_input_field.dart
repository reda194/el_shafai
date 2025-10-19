import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';

class ChatInputField extends StatefulWidget {
  final Function(String) onSendMessage;
  final bool isEnabled;

  const ChatInputField({
    super.key,
    required this.onSendMessage,
    this.isEnabled = true,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      widget.onSendMessage(message);
      _controller.clear();
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.homeSecondaryText.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Attachment button
          IconButton(
            onPressed: widget.isEnabled
                ? () {
                    // TODO: Implement attachment functionality
                  }
                : null,
            icon: Icon(
              Icons.attach_file,
              color: widget.isEnabled
                  ? AppColors.homeSecondaryText
                  : AppColors.homeSecondaryText.withOpacity(0.5),
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),

          const SizedBox(width: 12),

          // Text field
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.onboardingBackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.homeSecondaryText.withOpacity(0.1),
                ),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.isEnabled,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 14,
                  color: AppColors.primary,
                ),
                decoration: InputDecoration(
                  hintText: 'اكتب رسالتك هنا...',
                  hintStyle: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 14,
                    color: AppColors.homeSecondaryText.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Send button
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: widget.isEnabled && _controller.text.trim().isNotEmpty
                  ? AppColors.primary
                  : AppColors.homeSecondaryText.withOpacity(0.1),
              borderRadius: BorderRadius.circular(22),
            ),
            child: IconButton(
              onPressed: widget.isEnabled && _controller.text.trim().isNotEmpty
                  ? _sendMessage
                  : null,
              icon: Icon(
                Icons.send,
                color: widget.isEnabled && _controller.text.trim().isNotEmpty
                    ? Colors.white
                    : AppColors.homeSecondaryText.withOpacity(0.5),
                size: 20,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
