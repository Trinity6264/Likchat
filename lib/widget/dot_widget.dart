import 'dart:async';

import 'package:flutter/material.dart';

class DotWidget extends StatefulWidget {
  final int millSec;
  const DotWidget({
    super.key,
    required this.millSec,
  });

  @override
  State<DotWidget> createState() => _DotWidgetState();
}

class _DotWidgetState extends State<DotWidget> {
  int index = 0;

  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: widget.millSec), (timer) {
      setState(() {
        index++;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      width: size.width * .016,
      height: size.height * .02,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index % 2 == 0
            ? Colors.purpleAccent
            : const Color.fromARGB(78, 223, 64, 251),
      ),
    );
  }
}
