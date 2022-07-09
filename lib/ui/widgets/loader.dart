import 'package:chat_app2/logic/bloc/loader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // TODO another test variant of creating loader
        // BlocListener<LoaderBloc, int>(
        //   listener: (context, state) async {
        //     if (state > 0) {
        //       showDialog(
        //         barrierDismissible: false,
        //         context: context,
        //         builder: (context) =>
        //             const Center(child: CircularProgressIndicator()),
        //       );

        //       await Future.delayed(Duration(seconds: 1));

        //       showDialog(
        //         barrierDismissible: false,
        //         context: context,
        //         builder: (context) =>
        //             const Center(child: CircularProgressIndicator()),
        //       );
        //     }
        //   },
        //   child: const SizedBox(),
        // );
        BlocBuilder<LoaderBloc, int>(
      builder: (context, state) => state > 0
          ? Container(
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : const SizedBox.shrink(),
    );
  }
}
