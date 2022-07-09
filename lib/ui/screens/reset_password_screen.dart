import 'package:chat_app2/logic/bloc/loader_bloc.dart';
import 'package:chat_app2/ui/screens/main_page_layout.dart';
import 'package:chat_app2/ui/widgets/main_appbar.dart';
import 'package:chat_app2/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      appBar: const MainAppBar(title: 'Reset Password'),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Receive an email to reset password'),
              SizedBox(height: 50.h),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
                validator: (value) {
                  if (value == null || !EmailValidator.validate(value)) {
                    return 'Enter a valid email';
                  }

                  return null;
                },
              ),
              SizedBox(height: 50.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 60.w, vertical: 12.h)),
                onPressed: _resetPassword,
                child: const Text('RESET'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _resetPassword() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    context.read<LoaderBloc>().add(IncrementLoader());

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _controller.text.trim());
    } catch (e) {
      Utils.showSnackbar(e.toString());
    } finally {
      context.read<LoaderBloc>().add(DecrementLoader());

      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}
