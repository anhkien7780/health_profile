import 'package:equatable/equatable.dart';
import 'package:health_profile/models/entities/appointment_display.dart';
import 'package:health_profile/models/entities/user_profile.dart';
import 'package:health_profile/models/enum/loading_status.dart';

class HomeState extends Equatable {
  const HomeState({
    this.selectedPageIndex = 1,
    this.appointments = const [],
    this.userProfile,
    this.loadingStatus = LoadingStatus.idle,
  });

  final int selectedPageIndex;
  final List<AppointmentDisplay> appointments;
  final UserProfile? userProfile;
  final LoadingStatus loadingStatus;

  HomeState copyWith({
    int? selectedPageIndex,
    List<AppointmentDisplay>? appointments,
    UserProfile? userProfile,
    LoadingStatus? loadingStatus,
  }) {
    return HomeState(
      selectedPageIndex: selectedPageIndex ?? this.selectedPageIndex,
      appointments: appointments ?? this.appointments,
      userProfile: userProfile ?? this.userProfile,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List<Object?> get props => [
    selectedPageIndex,
    appointments,
    userProfile,
    loadingStatus,
  ];
}
