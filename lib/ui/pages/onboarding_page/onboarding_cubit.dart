import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState(currentPage: 1));
  final pageController = PageController();

  Future<void> nextPage() async {
    await pageController.nextPage(
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
    );
  }

  void updatePage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  Future<void> onSkip() async {
    await pageController.animateToPage(
      3,
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
    );
  }
}
