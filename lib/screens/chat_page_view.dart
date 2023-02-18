import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:likchat/model/chat_model.dart';
import 'package:likchat/widget/bot_loading_chat.dart';
import 'package:likchat/widget/chat_card.dart';

class ChatPageView extends StatefulWidget {
  const ChatPageView({super.key});

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  late final TextEditingController controller;
  late final ScrollController scrollController;
  late final FocusNode fNode;
  bool isLoading = false;

  @override
  void initState() {
    controller = TextEditingController();
    scrollController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0,
    );

    fNode = FocusNode();
    super.initState();
  }

  void showBanner() {
    ScaffoldMessenger.of(context).showMaterialBanner(
      const MaterialBanner(
        backgroundColor: Colors.purpleAccent,
        content: Text(
          'Please  can\'t send an empty message',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Icon(
            Icons.error_outline,
            color: Colors.white,
          )
        ],
      ),
    );
    Future.delayed(
      const Duration(seconds: 5),
      () {
        ScaffoldMessenger.of(context).clearMaterialBanners();
      },
    );
  }

  Future<void> sendChat() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(
      const Duration(seconds: 5),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: const Text(
          'LIKCHAT',
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    reverse: true,
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(
                      children: [
                        Column(
                          children: chatList
                              .map((e) => ChatCard(chatModel: e))
                              .toList(),
                        ),
                        !isLoading ? const SizedBox() : const BotLoadingChat(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: size.width * .9,
                constraints: BoxConstraints(
                  minHeight: size.height * .07,
                  maxHeight: size.height * .15,
                ),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        focusNode: fNode,
                        minLines: 1,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'Ask me something?',
                          hintStyle: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (controller.text == '') {
                          showBanner();
                          return;
                        }
                        log(controller.text);
                        fNode.unfocus();
                        controller.clear();
                        sendChat();
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          scrollController.hasClients && scrollController.offset > 200
              ? Positioned(
                  bottom: 100,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                      child: const Icon(
                        Icons.keyboard_double_arrow_down,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    fNode.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
