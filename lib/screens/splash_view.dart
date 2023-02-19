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
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ChatPageView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/pic.jpg',
            width: double.infinity,
            height: double.infinity,
          ),
          const AnimatingBackground(),
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'LIKCHAT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * .18,
                  ),
                ),
                Text(
                  'Make\'s life easy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * .04,
                  ),
                ),
                const Spacer(),
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(height: size.height * .1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
