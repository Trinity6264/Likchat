import 'package:flutter/material.dart';
import 'package:likchat/widget/dot_widget.dart';

class BotLoadingChat extends StatelessWidget {
  const BotLoadingChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                DotWidget(millSec: 100),
                DotWidget(millSec: 200),
                DotWidget(millSec: 300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
