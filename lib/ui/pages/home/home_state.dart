import 'package:equatable/equatable.dart';
import 'package:health_profile/models/entities/user_profile.dart';
import 'package:health_profile/models/enum/loading_status.dart';

class HomeState extends Equatable {
  const HomeState({
    this.selectedPageIndex = 1,
    this.appointmentsCount = 10,
    this.userProfile,
    this.loadingStatus = LoadingStatus.idle,
  });

  final int selectedPageIndex;
  final int appointmentsCount;
  final UserProfile? userProfile;
  final LoadingStatus loadingStatus;

  HomeState copyWith({
    int? selectedPageIndex,
    int? appointmentsCount,
    UserProfile? userProfile,
    LoadingStatus? loadingStatus,
  }) {
    return HomeState(
      selectedPageIndex: selectedPageIndex ?? this.selectedPageIndex,
      appointmentsCount: appointmentsCount ?? this.appointmentsCount,
      userProfile: userProfile ?? this.userProfile,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List<Object?> get props => [
    selectedPageIndex,
    appointmentsCount,
    userProfile,
    loadingStatus,
  ];
}
