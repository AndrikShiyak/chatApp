import 'package:chat_app2/logic/cubit/user_cubit.dart';
import 'package:chat_app2/ui/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: ((context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = (snapshot.data as QuerySnapshot).docs;

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) => MessageBubble(
            message: chatDocs[index]['message'],
            userName: chatDocs[index]['userName'],
            userImage: chatDocs[index]['userImage'],
            isMe: chatDocs[index]['userId'] ==
                context.read<UserCubit>().state.user?.id,
          ),
        );
      }),
    );
  }
}
