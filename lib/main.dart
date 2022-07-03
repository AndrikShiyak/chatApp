import 'package:chat_app2/logic/bloc/loader_bloc.dart';
import 'package:chat_app2/logic/debug/app_bloc_observer.dart';
import 'package:chat_app2/router.dart';
import 'package:chat_app2/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  BlocOverrides.runZoned(
    () => runApp(
      const MyApp(),
    ),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // MaterialApp(
        //   title: 'Chat App',
        //   scaffoldMessengerKey: Utils.messengerKey,
        //   theme: ThemeData(
        //     primarySwatch: Colors.pink,
        //   ),
        //   home: Scaffold(),
        // );

        BlocProvider(
      create: (context) => LoaderBloc(),
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        builder: (context, _) => SafeArea(
          child: MaterialApp(
            title: 'Chat App',
            scaffoldMessengerKey: Utils.messengerKey,
            theme: ThemeData(
              primarySwatch: Colors.pink,
            ),
            onGenerateRoute: AppRouter.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
