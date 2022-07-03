import 'package:chat_app2/screens/main_page_layout.dart';
import 'package:chat_app2/utils/pop_ups.dart';
import 'package:chat_app2/widgets/main_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    // final String userName =
    //     FirebaseAuth.instance.currentUser?.displayName ?? '';

    // final String? imageUrl = FirebaseAuth.instance.currentUser?.photoURL;

    return MainPageLayout(
      appBar: const MainAppBar(title: 'Profile'),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 70.w,
                  // backgroundImage:
                  // imageUrl != null ? NetworkImage(imageUrl) : null,
                  // child: _image != null ? Image.file(_image!) : null,
                ),
                SizedBox(width: 30.w),
                Expanded(
                  child: Text(
                    // userName,
                    'Username',
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Center(
              child: TextButton(
                onPressed: () async {
                  // TODO Upload image to Firebase storage

                  final image = await PopUps.showCameraGalleryPopup(context);
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
