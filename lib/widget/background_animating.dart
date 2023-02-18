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
    Color(0xff171B70),
    Color(0xFF0E147E),
    Color(0xFF2730E2),
    Color(0xFF0D1046),
    Color(0xFF01042C),
  ];

  int index = 0;
  Color bottomColor = const Color(0xFF092646);
  Color topColor = const Color(0xFF410D75);
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
