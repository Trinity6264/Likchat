import 'package:flutter/material.dart';
import 'package:likchat/screens/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LikChat',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SplashView(),
    );
  }
}
