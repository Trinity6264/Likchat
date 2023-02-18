import 'dart:async';

import 'package:flutter/material.dart';
import 'package:likchat/screens/chat_page_view.dart';
import 'package:likchat/widget/background_animating.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    wait4While();
    super.initState();
  }

  Future<void> wait4While() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ChatPageView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(),
          const AnimatingBackground(),
        ],
      ),
    );
  }
}
