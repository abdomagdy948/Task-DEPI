import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/firebase_options.dart';
import 'package:flutter_task/models/cubits/category_cubit/category_cubit.dart';
import 'package:flutter_task/models/cubits/favorit_category_cubit/favorit_category_cubit.dart';
import 'package:flutter_task/models/cubits/firebase_auth_cubit/firebase_auth_cubit.dart';
import 'package:flutter_task/screens/splach_screen/splach_screen.dart';
import 'package:flutter_task/services/firebase_services/firebase_messages/firebase_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseNotificationService().setUp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FirebaseAuthCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => FavoritCategoryCubit()),
      ],
      child: const FlutterTask(),
    ),
  );
}

class FlutterTask extends StatelessWidget {
  const FlutterTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
