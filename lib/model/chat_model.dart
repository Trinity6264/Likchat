enum User { bot, human }

class ChatModel {
  final int id;
  final String content;
  final DateTime dateTime;
  final User user;

  const ChatModel({
    required this.id,
    required this.content,
    required this.dateTime,
    required this.user,
  });
}

List<ChatModel> chatList = [
  ChatModel(
    id: 1,
    content: 'Hello',
    dateTime: DateTime.now(),
    user: User.human,
  ),
  ChatModel(
    id: 2,
    content:
        'Hello, How are are you doing Hello, How are are you doing Hello, How are are you doing Hello, How are are you doing Hello, How are are you doing Hello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doing',
    dateTime: DateTime.now(),
    user: User.bot,
  ),
  ChatModel(
    id: 3,
    content: 'I\'m good and you?',
    dateTime: DateTime.now(),
    user: User.human,
  ),
  ChatModel(
    id: 4,
    content: 'I\'m doing well',
    dateTime: DateTime.now(),
    user: User.bot,
  ),
  ChatModel(
    id: 4,
    content: 'Please, what can i do for you?',
    dateTime: DateTime.now(),
    user: User.bot,
  ),
  ChatModel(
    id: 1,
    content: 'Hello',
    dateTime: DateTime.now(),
    user: User.human,
  ),
  ChatModel(
    id: 2,
    content:
        'Hello, How are are you doing Hello, How are are you doing Hello, How are are you doing Hello, How are are you doing Hello, How are are you doing Hello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doingHello, How are are you doing',
    dateTime: DateTime.now(),
    user: User.bot,
  ),
  ChatModel(
    id: 3,
    content: 'I\'m good and you?',
    dateTime: DateTime.now(),
    user: User.human,
  ),
  ChatModel(
    id: 4,
    content: 'I\'m doing well',
    dateTime: DateTime.now(),
    user: User.bot,
  ),
  ChatModel(
    id: 4,
    content: 'Please, what can i do for you?',
    dateTime: DateTime.now(),
    user: User.bot,
  ),
];
