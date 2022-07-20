import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.userName,
    required this.isMe,
    this.userImage,
  }) : super(key: key);

  final String message;
  final String userName;
  final String? userImage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(minWidth: 50.w, maxWidth: 230.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                  bottomLeft: isMe ? Radius.circular(25.r) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : Radius.circular(25.r),
                ),
                color: isMe
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey.shade400,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 20.w,
              ),
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                crossAxisAlignment:
                    !isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: isMe ? -10.w : null,
          left: isMe ? null : -10.w,
          child: CircleAvatar(
            radius: 16.r,
            backgroundImage:
                userImage != null ? NetworkImage(userImage!) : null,
          ),
        ),
      ],
    );
  }
}
