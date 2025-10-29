import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void onDestinationPressed(int? selectedPageIndex) {
    emit(state.copyWith(selectedPageIndex: selectedPageIndex));
    log("Selected page: ${state.selectedPageIndex.toString()}");
  }
}
