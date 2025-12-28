import 'package:equatable/equatable.dart';

class ProfileRegisterState extends Equatable {
  final bool isLoading;
  final String? error;

  const ProfileRegisterState({
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object?> get props => [isLoading, error];

  ProfileRegisterState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return ProfileRegisterState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
