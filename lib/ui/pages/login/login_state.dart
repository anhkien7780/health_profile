import 'package:equatable/equatable.dart';
import 'package:health_profile/models/enum/loading_status.dart';

class LoginState extends Equatable {
  final LoadingStatus loadStatus;
  final String? errorMessage;

  const LoginState({
    this.loadStatus = LoadingStatus.idle,
    this.errorMessage,
  });

  LoginState copyWith({
    LoadingStatus? loadStatus,
    String? errorMessage,
  }) {
    return LoginState(
      loadStatus: loadStatus ?? this.loadStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [loadStatus, errorMessage];
}
