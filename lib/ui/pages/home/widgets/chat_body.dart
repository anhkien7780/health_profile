import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/repositories/conversation_repository.dart';
import 'package:health_profile/router/router_config.dart';
import 'package:health_profile/ui/pages/home/widgets/conversation/conversation_cubit.dart';
import 'package:health_profile/ui/pages/home/widgets/conversation/conversation_state.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConversationCubit(
        conversationRepository: ConversationRepositoryImpl(),
      ),
      child: const _ChatBodyView(),
    );
  }
}

class _ChatBodyView extends StatelessWidget {
  const _ChatBodyView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).conversations,
          style: theme.textTheme.titleSmall?.copyWith(color: Colors.black),
        ),
        const SizedBox(height: AppDimens.paddingNormal),
        Expanded(
          child: BlocBuilder<ConversationCubit, ConversationState>(
            builder: (context, state) {
              if (state.status == ConversationStatus.loading ||
                  state.status == ConversationStatus.initial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == ConversationStatus.failure) {
                return Center(
                  child: Text(S.of(context).failedToLoadConversations),
                );
              }
              return ListView.separated(
                itemCount: state.conversations.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppDimens.paddingSmall),
                itemBuilder: (context, index) {
                  final conversation = state.conversations[index];
                  return ListTile(
                    onTap: () {
                      context.pushNamed(
                        AppRouter.chat,
                        pathParameters: {'conversationId': conversation.id},
                        queryParameters: {
                          'name': conversation.name,
                          'specialty': conversation.specialty,
                        },
                      );
                    },
                    tileColor: theme.colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppDimens.borderRadiusNormal),
                      ),
                    ),
                    title: Text(
                      conversation.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      conversation.lastMessage,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: AppDimens.iconChatRadius,
                      backgroundImage: AssetImage(conversation.avatar),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
