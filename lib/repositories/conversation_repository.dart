import 'package:health_profile/common/app_images.dart';
import 'package:health_profile/models/entities/conversation.dart';

abstract class ConversationRepository {
  Future<List<Conversation>> getConversations();
}

class ConversationRepositoryImpl implements ConversationRepository {
  @override
  Future<List<Conversation>> getConversations() async {
    return [
      Conversation(
        id: 'dr_hung',
        name: 'BS. Nguyễn Văn Hùng',
        specialty: 'Khoa Tim mạch',
        lastMessage: 'Bạn: Chào bác sĩ, tôi dạo này hay bị đau đầu và chóng mặt.',
        avatar: AppImages.icDoctor,
      ),
      Conversation(
        id: 'dr_mai',
        name: 'BS. Trần Thị Mai',
        specialty: 'Khoa Nội tiết',
        lastMessage: 'BS. Trần Thị Mai: Kết quả của bạn bình thường nhé, không có gì đáng lo ngại.',
        avatar: AppImages.icDoctor,
      ),
    ];
  }
}
