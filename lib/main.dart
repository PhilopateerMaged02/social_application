import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/SocialApp/Login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String SUPABASE_URL = 'https://slyghrmfgwhlncbvtjnc.supabase.co';
  const String SUPABASE_KEY =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNseWdocm1mZ3dobG5jYnZ0am5jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzExNjA1MjYsImV4cCI6MjA0NjczNjUyNn0.kINmFEl-ZNUt0AKXqcLqTtg0saPa_-_Bfzye5xqHKOY";

  await Supabase.initialize(
    url: 'https://slyghrmfgwhlncbvtjnc.supabase.co',
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNseWdocm1mZ3dobG5jYnZ0am5jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzExNjA1MjYsImV4cCI6MjA0NjczNjUyNn0.kINmFEl-ZNUt0AKXqcLqTtg0saPa_-_Bfzye5xqHKOY",
  );

  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatefulWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return BlocProvider(
      create: (BuildContext context) => SocialAppCubit()
        ..getUserDataSupabase()
        ..fetchAndFillPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: widget.startWidget,
        theme: ThemeData.light(),
      ),
    );
  }
}
