

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:likchat/model/chat_model.dart';
import 'package:likchat/repo/chat_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  ChatCubit({required this.chatRepo}) : super(ChatInitial());

  final List<ChatModel> listOfChat = [];

  void getChat({required String txt}) async {
    try {
      final chat = ChatModel(
        id: DateTime.now().millisecond.toString(),
        content: txt,
        dateTime: DateTime.now(),
        user: User.human,
      );
      listOfChat.add(chat);
      emit(ChatResponded(listOfChats: listOfChat));
      emit(ChatLoading());
      final resp = await chatRepo.sendChat(txt);
      if (resp != null) {
        listOfChat.add(resp);
        emit(ChatResponded(listOfChats: listOfChat));
      }
    } catch (e) {
      emit(const ChatError());
    }
  }
}
