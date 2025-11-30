import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/common/app_images.dart';
import 'package:health_profile/ui/pages/chat/chat_cubit.dart';
import 'package:health_profile/ui/pages/chat/chat_navigator.dart';
import 'package:health_profile/ui/pages/chat/chat_state.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ChatCubit(navigator: ChatNavigator(context: context));
      },
      child: const ChatChildPage(),
    );
  }
}

class ChatChildPage extends StatefulWidget {
  const ChatChildPage({super.key});

  @override
  State<ChatChildPage> createState() => _ChatChildPageState();
}

class _ChatChildPageState extends State<ChatChildPage> {
  late final ChatCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ChatCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primaryContainer,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.colorScheme.onPrimaryContainer,
          ),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: AppDimens.iconChatRadius,
              backgroundImage: AssetImage(AppImages.icDoctor),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: AppDimens.paddingSmall),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Smith',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  'Cardiologist',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                return ListView.builder(
                  controller: _cubit.scrollController,
                  padding: const EdgeInsets.all(AppDimens.paddingNormal),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return _buildMessageItem(message);
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    final isMe = message.isMe;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.paddingNormal),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: AppDimens.iconChatRadius,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(AppImages.icDoctor),
            ),
            const SizedBox(width: AppDimens.paddingSmall),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingNormal,
                vertical: AppDimens.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: isMe
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(
                  AppDimens.borderRadiusNormal,
                ),
              ),
              child: Column(
                spacing: AppDimens.paddingSmallest,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isMe
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm').format(message.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isMe
                          ? theme.colorScheme.onPrimary.withValues(alpha: 0.7)
                          : theme.colorScheme.onSurfaceVariant.withValues(
                              alpha: 0.7,
                            ),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingSmall),
      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _cubit.messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimens.borderRadiusBig,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingNormal,
                    vertical: AppDimens.paddingSmall,
                  ),
                ),
                minLines: 1,
                maxLines: 5,
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: theme.colorScheme.primary),
              onPressed: () {
                _cubit.sendMessage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
