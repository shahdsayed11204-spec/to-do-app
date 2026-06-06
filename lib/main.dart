import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'core/constants/bloc_observer.dart';
import 'feature/todo/presentation/views/home_layout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      home:HomeLayout(),
    );
  }
}

