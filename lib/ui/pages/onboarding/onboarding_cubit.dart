import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_navigator.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.navigator}) : super(OnboardingState(currentPage: 1));
  final pageController = PageController();
  final OnboardingNavigator navigator;


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

  Future<void> onGetStarted() async {
    await navigator.openLoginPage();
  }
}
