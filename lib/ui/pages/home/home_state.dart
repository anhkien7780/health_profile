import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({this.selectedPageIndex = 1, this.appointmentsCount = 0});

  final int selectedPageIndex;
  final int appointmentsCount;

  HomeState copyWith({int? selectedPageIndex, int? appointmentsCount}) {
    return HomeState(
      selectedPageIndex: selectedPageIndex ?? this.selectedPageIndex,
      appointmentsCount: appointmentsCount ?? this.appointmentsCount,
    );
  }

  @override
  List<Object?> get props => [selectedPageIndex, appointmentsCount];
}
