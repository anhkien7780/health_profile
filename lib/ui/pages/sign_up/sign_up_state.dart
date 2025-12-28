import 'package:equatable/equatable.dart';
import 'package:health_profile/models/enum/loading_status.dart';

class SignUpState extends Equatable {
  const SignUpState({this.status = LoadingStatus.idle, this.errorMessage});

  final LoadingStatus status;
  final String? errorMessage;

  SignUpState copyWith({LoadingStatus? status, String? errorMessage}) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
