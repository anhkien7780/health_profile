import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/repositories/chat_repository.dart';
import 'package:health_profile/ui/pages/chat/chat_navigator.dart';
import 'package:health_profile/ui/pages/chat/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.navigator,
    required this.chatRepository,
    required this.conversationId,
  }) : super(const ChatState()) {
    _loadMessages();
  }

  final ChatNavigator navigator;
  final ChatRepository chatRepository;
  final String conversationId;
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  Future<void> _loadMessages() async {
    final messages = await chatRepository.getChatMessages(conversationId);
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
