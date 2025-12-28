import 'package:flutter/foundation.dart';

@immutable
class Conversation {
  const Conversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.avatar,
    required this.specialty,
  });

  final String id;
  final String name;
  final String lastMessage;
  final String avatar;
  final String specialty;
}
