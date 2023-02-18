import 'package:flutter/material.dart';
import 'package:likchat/model/chat_model.dart';

class ChatCard extends StatelessWidget {
  final ChatModel chatModel;
  const ChatCard({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
            child: Text(
              chatModel.content,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
