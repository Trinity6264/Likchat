import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:likchat/model/chat_model.dart';
import 'package:likchat/repo/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepo chatRepo;
  ChatBloc({required this.chatRepo}) : super(ChatInitial()) {
    on<ChatEventSend>((event, emit) async {
      await getPrompt();
    });
  }
  final List<ChatModel> models = [];

  Future<void> getPrompt() async {
    try {
      on<ChatEventResponded>((event, emit) async {
        final model = ChatModel(
          id: 1,
          content: 'How are you doing?',
          dateTime: DateTime.now(),
          user: User.human,
        );
        models.add(model);
        emit(ChatBotResponse(chatModel: models));
      });
      on<ChatEventResponding>((event, emit) => emit(ChatBotResponding()));
      final res = await chatRepo.sendChat('How are you doing?');
      if (res != null) return;
      on<ChatEventResponded>((event, emit) async {});
    } on SocketException catch (_) {
      on<ChatEventFailed>(
        (event, emit) => emit(
          const ChatBotFailed(errText: 'No internet connection'),
        ),
      );
    } on Exception catch (__) {
      on<ChatEventFailed>(
        (event, emit) => emit(
          const ChatBotFailed(errText: 'Something happen,try again'),
        ),
      );
    }
  }
}
