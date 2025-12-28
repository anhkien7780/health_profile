import 'package:equatable/equatable.dart';
import 'package:health_profile/models/entities/conversation.dart';

enum ConversationStatus { initial, loading, success, failure }

class ConversationState extends Equatable {
  const ConversationState({
    this.status = ConversationStatus.initial,
    this.conversations = const [],
  });

  final ConversationStatus status;
  final List<Conversation> conversations;

  ConversationState copyWith({
    ConversationStatus? status,
    List<Conversation>? conversations,
  }) {
    return ConversationState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
    );
  }

  @override
  List<Object> get props => [status, conversations];
}
