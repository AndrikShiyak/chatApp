import 'dart:io';

import 'package:chat_app2/logic/cubit/user_cubit.dart';
import 'package:chat_app2/ui/screens/main_page_layout.dart';
import 'package:chat_app2/ui/widgets/main_appbar.dart';
import 'package:chat_app2/utils/pop_ups.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // File? _image;

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      appBar: const MainAppBar(title: 'Profile'),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    final String? imageUrl = state.user?.imageUrl;

                    return CircleAvatar(
                      radius: 70.w,
                      backgroundImage:
                          imageUrl != null ? NetworkImage(imageUrl) : null,
                    );
                  },
                ),
                SizedBox(width: 30.w),
                Expanded(
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return Text(
                        state.user?.name ?? 'Username',
                        style: Theme.of(context).textTheme.headline6,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Center(
              child: TextButton(
                onPressed: () async {
                  final updateUserImage =
                      context.read<UserCubit>().updateUserImage;

                  final File? image =
                      await PopUps.showCameraGalleryPopup(context);

                  if (image == null) return;

                  updateUserImage(
                    image: image,
                  );
                },
                child: const Text('Change Avatar'),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
