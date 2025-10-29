import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({this.selectedPageIndex = 1});

  final int selectedPageIndex;

  HomeState copyWith({int? selectedPageIndex}) {
    return HomeState(
      selectedPageIndex: selectedPageIndex ?? this.selectedPageIndex,
    );
  }

  @override
  List<Object?> get props => [selectedPageIndex];
}
