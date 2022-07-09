import 'package:chat_app2/logic/cubit/auth_cubit.dart';
import 'package:chat_app2/router.dart';
import 'package:chat_app2/ui/screens/main_page_layout.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  bool _isLogin = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      enableLoader: false,
      backgroundColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Align(
          child: Container(
            constraints: BoxConstraints(
              minHeight: 270.h,
              maxHeight: 490.h,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    TextFormField(
                      key: const ValueKey('email'),
                      controller: _emailController,
                      decoration: const InputDecoration(label: Text('Email')),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required.';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Enter correct email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    if (!_isLogin) ...[
                      TextFormField(
                        key: const ValueKey('username'),
                        controller: _usernameController,
                        decoration:
                            const InputDecoration(label: Text('Username')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required.';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                    ],
                    TextFormField(
                      key: const ValueKey('password'),
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(label: Text('Password')),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required.';
                        } else if (value.length < 6) {
                          return 'Password must contain at least 6 characters';
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: 10.h),
                    if (!_isLogin) ...[
                      TextFormField(
                        key: const ValueKey('repeat_password'),
                        controller: _repeatPasswordController,
                        decoration: const InputDecoration(
                            label: Text('Repeat Password')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required.';
                          } else if (value != _passwordController.text.trim()) {
                            return 'Incorrect password';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 10.h),
                    ],
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: _isLogin
                            ? () => _signIn(
                                  context.read<AuthCubit>().signIn,
                                )
                            : () => _signUp(
                                  context.read<AuthCubit>().signUp,
                                ),
                        child: Text(_isLogin ? 'Login' : 'Sign Up'),
                      ),
                    SizedBox(height: 10.h),
                    if (_isLogin) ...[
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRouter.resetPassword),
                        child: const Text('Forgot password?'),
                      ),
                      SizedBox(height: 20.h),
                    ],
                    GestureDetector(
                      onTap: () => setState(
                        () => _isLogin = !_isLogin,
                      ),
                      child: Text(_isLogin
                          ? 'I don\'t have an account'
                          : 'I already have an account'),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _signIn(
    Future<void> Function({
      required String email,
      required String password,
    })
        signIn,
  ) async {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    setState(() {
      _isLoading = true;
    });

    await signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future _signUp(
    Future<void> Function({
      required String email,
      required String password,
      required String name,
    })
        signUp,
  ) async {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    setState(() {
      _isLoading = true;
    });

    await signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _usernameController.text.trim(),
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
