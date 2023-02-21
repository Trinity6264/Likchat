// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatResponded extends ChatState {
  final List<ChatModel> listOfChats;

  const ChatResponded({required this.listOfChats});

  @override
  List<Object> get props => [listOfChats];
}

class ChatError extends ChatState {
  final String err;
  const ChatError({required this.err});
  @override
  List<Object> get props => [err];
}
