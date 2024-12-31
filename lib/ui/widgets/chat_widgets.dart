import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibber/core/constants/typography.dart';
import 'package:jibber/core/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isCurrentUser,
    required this.message,
  });

  final bool isCurrentUser;
  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final onPrimaryColor = theme.colorScheme.onPrimary;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isCurrentUser ? primaryColor : primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content ?? '',
              style: body.copyWith(
                color: isCurrentUser ? onPrimaryColor : primaryColor,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              _formatTimestamp(message.timestamp),
              style: small.copyWith(
                color: isCurrentUser
                    ? onPrimaryColor.withOpacity(0.7)
                    : primaryColor.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return '';
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

class BottomField extends StatelessWidget {
  const BottomField({
    super.key,
    required this.controller,
    required this.onTap,
  });

  final TextEditingController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide(
                      color: theme.colorScheme.primary.withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide:
                      BorderSide(color: theme.colorScheme.primary, width: 2),
                ),
                filled: true,
                fillColor: theme.inputDecorationTheme.fillColor ??
                    theme.colorScheme.surface,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            icon: const Icon(Icons.send),
            color: theme.colorScheme.primary,
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
