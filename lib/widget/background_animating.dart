import 'dart:async';

import 'package:flutter/material.dart';

class AnimatingBackground extends StatefulWidget {
  const AnimatingBackground({super.key});

  @override
  State<AnimatingBackground> createState() => _AnimatingBackgroundState();
}

class _AnimatingBackgroundState extends State<AnimatingBackground>
    with TickerProviderStateMixin {
  List<Color> colorList = const [
    Color.fromARGB(230, 23, 27, 112),
    Color.fromARGB(230, 14, 20, 126),
    Color.fromARGB(230, 39, 48, 226),
    Color.fromARGB(230, 13, 16, 70),
    Color.fromARGB(230, 1, 4, 44),
  ];

  int index = 0;
  Color bottomColor = const Color.fromARGB(230, 9, 39, 70);
  Color topColor = const Color.fromARGB(230, 65, 13, 117);
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        bottomColor = const Color(0xff33267c);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.infinity,
      height: double.infinity,
      duration: const Duration(seconds: 5),
      onEnd: () {
        setState(() {
          index = index + 1;
          bottomColor = colorList[index % colorList.length];
          topColor = colorList[(index + 1) % colorList.length];
        });
      },
      curve: Curves.easeInOutCubicEmphasized,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bottomColor, topColor],
          begin: begin,
          end: end,
        ),
      ),
    );
  }
}
