part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatEventSend extends ChatEvent {
  final bool isLoading;
  const ChatEventSend({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class ChatEventResponding extends ChatEvent {
  const ChatEventResponding();
}

class ChatEventResponded extends ChatEvent {
  const ChatEventResponded();
}

class ChatEventFailed extends ChatEvent {
  const ChatEventFailed();
}
