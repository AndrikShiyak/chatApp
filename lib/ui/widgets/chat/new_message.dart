import 'package:chat_app2/data/models/user_model.dart';
import 'package:chat_app2/logic/cubit/user_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage(UserModel user) async {
    FocusScope.of(context).unfocus();

    final userMap = {
      'message': _controller.text.trim(),
      'createdAt': Timestamp.now(),
      'userId': user.id,
      'userName': user.name,
      'userImage': user.imageUrl,
    };

    FirebaseFirestore.instance.collection('chat').doc().set(userMap);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onChanged: (_) => setState(() {}),
          ),
        ),
        IconButton(
          onPressed: _controller.text.trim().isEmpty
              ? null
              : () => _sendMessage(context.read<UserCubit>().state.user!),
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
