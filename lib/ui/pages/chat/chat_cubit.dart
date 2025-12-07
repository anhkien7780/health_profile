import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/ui/pages/chat/chat_navigator.dart';
import 'package:health_profile/ui/pages/chat/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.navigator}) : super(const ChatState()) {
    _loadMockMessages();
  }

  final ChatNavigator navigator;
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  void _loadMockMessages() {
    final messages = [
      ChatMessage(
        id: '1',
        text: 'Good morning, Doctor.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        id: '2',
        text: 'Hi there! How can I help you?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
      ChatMessage(
        id: '3',
        text: 'I have a question about my health profile.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
      ChatMessage(
        id: '4',
        text: 'Sure, what is your concern.',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
      ChatMessage(
        id: '5',
        text:
            'This is a looooooooooooooooooooooooooooooooooooooooooong message.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
    ];
    emit(state.copyWith(messages: messages));
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isMe: true,
      timestamp: DateTime.now(),
    );

    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(newMessage);

    emit(state.copyWith(messages: updatedMessages));
    messageController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Future<void> close() {
    messageController.dispose();
    scrollController.dispose();
    return super.close();
  }
}
