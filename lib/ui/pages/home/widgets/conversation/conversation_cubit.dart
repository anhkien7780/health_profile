import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/repositories/conversation_repository.dart';
import 'package:health_profile/ui/pages/home/widgets/conversation/conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit({required this.conversationRepository})
      : super(const ConversationState()) {
    fetchConversations();
  }

  final ConversationRepository conversationRepository;

  Future<void> fetchConversations() async {
    emit(state.copyWith(status: ConversationStatus.loading));
    try {
      final conversations = await conversationRepository.getConversations();
      emit(state.copyWith(
        status: ConversationStatus.success,
        conversations: conversations,
      ));
    } catch (e) {
      emit(state.copyWith(status: ConversationStatus.failure));
    }
  }
}
