import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likchat/logic/bloc/internet/internet_bloc.dart';
import 'package:likchat/screens/splash_view.dart';

void main() {
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;
  const MyApp({super.key, required this.connectivity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'LikChat',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const SplashView(),
      ),
    );
  }
}
