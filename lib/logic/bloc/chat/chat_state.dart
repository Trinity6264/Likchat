part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatBotResponding extends ChatState {}

class ChatBotResponse extends ChatState {
  final List<ChatModel> chatModel;
  const ChatBotResponse({required this.chatModel});

  @override
  List<Object> get props => [chatModel];
}

class ChatBotFailed extends ChatState {
  final String errText;
  const ChatBotFailed({required this.errText});

    @override
  List<Object> get props => [errText];
}
