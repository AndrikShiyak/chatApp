import 'package:chat_app2/widgets/loader.dart';
import 'package:flutter/material.dart';

class MainPageLayout extends StatelessWidget {
  const MainPageLayout({
    Key? key,
    this.backgroundColor,
    this.appBar,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,
          appBar: appBar,
          body: child,
        ),
        const LoaderWidget(),
      ],
    );
  }
}
