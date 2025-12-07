import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String id;
  final String text;
  final bool isMe;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isMe,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, text, isMe, timestamp];
}

class ChatState extends Equatable {
  final List<ChatMessage> messages;

  const ChatState({this.messages = const []});

  @override
  List<Object?> get props => [messages];

  ChatState copyWith({List<ChatMessage>? messages}) {
    return ChatState(messages: messages ?? this.messages);
  }
}
