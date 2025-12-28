import 'package:health_profile/ui/pages/chat/chat_state.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> getChatMessages(String conversationId);
}

class ChatRepositoryImpl implements ChatRepository {
  static final Map<String, List<ChatMessage>> _mockMessages = {
    'dr_hung': [
      ChatMessage(
        id: '1',
        text: 'Chào bác sĩ, tôi dạo này hay bị đau đầu và chóng mặt.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      ChatMessage(
        id: '2',
        text: 'Chào bạn, tình trạng này kéo dài bao lâu rồi ạ? Bạn có triệu chứng nào khác không?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
      ),
      ChatMessage(
        id: '3',
        text: 'Dạ khoảng 1 tuần rồi ạ. Thỉnh thoảng tôi còn thấy buồn nôn nữa.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      ChatMessage(
        id: '4',
        text: 'Bạn nên đến bệnh viện để được thăm khám và làm các xét nghiệm cần thiết nhé.',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
      ),
    ],
    'dr_mai': [
      ChatMessage(
        id: '1',
        text: 'Bác sĩ ơi, tôi đã có kết quả xét nghiệm máu rồi ạ.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      ),
      ChatMessage(
        id: '2',
        text: 'Kết quả của bạn bình thường nhé, không có gì đáng lo ngại.',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      ),
    ],
  };

  @override
  Future<List<ChatMessage>> getChatMessages(String conversationId) async {
    return _mockMessages[conversationId] ?? [];
  }
}
