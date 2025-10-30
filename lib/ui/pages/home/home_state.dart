import 'package:equatable/equatable.dart';
import 'package:health_profile/models/entities/user_profile.dart';

class HomeState extends Equatable {
  const HomeState({
    this.selectedPageIndex = 1,
    this.appointmentsCount = 0,
    this.userProfile,
  });

  final int selectedPageIndex;
  final int appointmentsCount;
  final UserProfile? userProfile;

  HomeState copyWith({
    int? selectedPageIndex,
    int? appointmentsCount,
    UserProfile? userProfile,
  }) {
    return HomeState(
      selectedPageIndex: selectedPageIndex ?? this.selectedPageIndex,
      appointmentsCount: appointmentsCount ?? this.appointmentsCount,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List<Object?> get props => [selectedPageIndex, appointmentsCount];
}
