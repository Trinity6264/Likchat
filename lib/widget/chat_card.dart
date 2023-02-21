// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:likchat/model/chat_model.dart';

class ChatCard extends StatelessWidget {
  final ChatModel chatModel;
  final VoidCallback onLongTap;
  const ChatCard({
    Key? key,
    required this.chatModel,
    required this.onLongTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final date = GetTimeAgo.parse(chatModel.dateTime!);
    return GestureDetector(
      onLongPress: chatModel.user == User.bot ? onLongTap : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: chatModel.user == User.human
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              constraints: BoxConstraints(
                maxWidth: size.width * .8,
              ),
              decoration: BoxDecoration(
                color: chatModel.user == User.human
                    ? Colors.deepPurpleAccent
                    : const Color.fromARGB(255, 104, 1, 122),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  chatModel.user == User.bot
                      ? AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              chatModel.content ?? '-',
                              curve: Curves.ease,
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              speed: const Duration(milliseconds: 50),
                            ),
                          ],
                          pause: const Duration(milliseconds: 20),
                          displayFullTextOnTap: true,
                          isRepeatingAnimation: false,
                          stopPauseOnTap: true,
                        )
                      : Text(
                          chatModel.content ?? '-',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  SizedBox(height: size.height * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      chatModel.user == User.bot
                          ? const Icon(Icons.bolt, color: Colors.amber)
                          : const SizedBox(),
                      Text(
                        date,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
