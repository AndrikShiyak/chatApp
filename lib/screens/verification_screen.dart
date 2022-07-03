import 'dart:async';

import 'package:chat_app2/screens/chat_screen.dart';
import 'package:chat_app2/screens/main_page_layout.dart';
import 'package:chat_app2/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _isVerified = false;
  bool _canResendVerification = true;
  Timer? _timer;

  @override
  void initState() {
    _isVerified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;

    if (!_isVerified) {
      _sendEmailVerification();
    }

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _checkVerification();
    });

    super.initState();
  }

  Future _sendEmailVerification() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      setState(() {
        _canResendVerification = false;
      });

      await user?.sendEmailVerification();
    } catch (e) {
      Utils.showSnackbar(e.toString());
    } finally {
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        _canResendVerification = true;
      });
    }
  }

  Future _checkVerification() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      _isVerified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;
    });

    if (_isVerified) {
      _timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isVerified
        ? const ChatScreen()
        : MainPageLayout(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      'A verification email has been sent to your email'),
                  SizedBox(height: 20.h),
                  ElevatedButton.icon(
                    onPressed: _canResendVerification
                        ? () => _sendEmailVerification()
                        : null,
                    icon: const Icon(Icons.send),
                    label: const Text('Resend email'),
                  ),
                  SizedBox(height: 20.h),
                  TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          );
  }
}
