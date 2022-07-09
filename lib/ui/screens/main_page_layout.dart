import 'package:chat_app2/ui/widgets/loader.dart';
import 'package:flutter/material.dart';

class MainPageLayout extends StatelessWidget {
  const MainPageLayout({
    Key? key,
    this.backgroundColor,
    this.appBar,
    required this.child,
    this.enableLoader = true,
  }) : super(key: key);

  final Widget child;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final bool enableLoader;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,
          appBar: appBar,
          body: child,
        ),
        if (enableLoader) const LoaderWidget(),
      ],
    );
  }
}
