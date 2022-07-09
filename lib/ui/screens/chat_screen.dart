import 'package:chat_app2/router.dart';
import 'package:chat_app2/ui/screens/main_page_layout.dart';
import 'package:chat_app2/ui/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      appBar: MainAppBar(
        title: 'Chat',
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AppRouter.profile),
            child: const CircleAvatar(),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      child: const Center(
        child: Text('Chat'),
      ),
    );
  }
}
