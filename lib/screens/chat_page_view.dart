import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likchat/logic/bloc/internet/internet_bloc.dart';
import 'package:likchat/logic/cubit/chat/chat_cubit.dart';
import 'package:likchat/utils/utils.dart';
import 'package:likchat/widget/bot_loading_chat.dart';
import 'package:likchat/widget/chat_card.dart';
import 'package:likchat/widget/try_again.dart';
import 'dart:io' show Platform;

class ChatPageView extends StatefulWidget {
  const ChatPageView({super.key});

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  late final TextEditingController controller;
  late final ScrollController scrollController;
  late final StreamSubscription subscription;
  late final FocusNode fNode;
  bool isLoading = false;
  String prompt = '';

  @override
  void initState() {
    controller = TextEditingController();
    scrollController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0,
    );
    scrollController.addListener(() {
      setState(() {});
    });
    subscription = Connectivity().onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.mobile ||
            event == ConnectivityResult.wifi) {
          context.read<InternetBloc>().add(const InternetConnectedEvent());
        } else if (event == ConnectivityResult.none) {
          context.read<InternetBloc>().add(const InternetDisConnectedEvent());
        }
      },
      onError: (e) {
        context.read<InternetBloc>().add(const InternetDisConnectedEvent());
      },
    );

    fNode = FocusNode();
    super.initState();
  }

  Future<void> copyToClipBoard(String txt) async {
    Clipboard.setData(ClipboardData(text: txt));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final chatModels = context.read<ChatCubit>();

    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          width: Platform.isLinux || Platform.isLinux
              ? size.width * .035
              : size.width * .1,
          // fit: BoxFit.cover,
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 18, right: 10),
            child: Text(
              'Infotess',
              style: TextStyle(
                color: Colors.white,
                fontSize: Platform.isLinux || Platform.isLinux
                    ? size.width * .02
                    : size.width * .045,
              ),
            ),
          ),
          const Icon(Icons.help_outline_outlined, color: Colors.white),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocListener<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is InternetConnected) {
            closeInternetBanner(context);
          } else if (state is InternetDisConnected) {
            showInternetBanner(context, state.message);
          }
        },
        child: Stack(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 7,
                sigmaY: 7,
                tileMode: TileMode.clamp,
              ),
              child: Image.asset(
                'assets/bg.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
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
                          BlocBuilder<ChatCubit, ChatState>(
                            builder: (context, state) {
                              if (state is ChatInitial &&
                                  chatModels.listOfChat.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              if (chatModels.listOfChat.isNotEmpty) {
                                return Column(
                                  children: chatModels.listOfChat
                                      .map(
                                        (e) => ChatCard(
                                          chatModel: e,
                                          onLongTap: () {
                                            copyToClipBoard(e.content ?? '-');
                                            showSnackBar(context);
                                          },
                                        ),
                                      )
                                      .toList(),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          BlocBuilder<ChatCubit, ChatState>(
                            builder: (context, state) {
                              if (state is ChatLoading) {
                                return const BotLoadingChat();
                              }
                              if (state is ChatError) {
                                return TryAgainWidget(onTap: () {
                                  chatModels.getChat(txt: prompt);
                                });
                              }
                              return const SizedBox();
                            },
                          )
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
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Ask me something...',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      BlocBuilder<InternetBloc, InternetState>(
                        builder: (context, state) {
                          return IconButton(
                            tooltip: state is InternetDisConnected
                                ? 'Unavailable'
                                : 'Send',
                            onPressed: () async {
                              if (state is InternetDisConnected) return;
                              if (controller.text == '') {
                                showBanner(context);
                                return;
                              }
                              chatModels.getChat(txt: controller.text);
                              prompt = controller.text;
                              fNode.unfocus();
                              controller.clear();
                            },
                            icon: state is InternetDisConnected
                                ? const Icon(
                                    Icons.do_not_disturb_alt_outlined,
                                    color: Colors.white24,
                                  )
                                : const Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                  ),
                          );
                        },
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
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    fNode.dispose();
    scrollController.dispose();
    subscription.cancel();
    super.dispose();
  }
}
