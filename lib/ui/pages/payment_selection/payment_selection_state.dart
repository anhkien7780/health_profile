import 'package:equatable/equatable.dart';
import 'package:health_profile/models/enum/loading_status.dart';

class PaymentSelectionState extends Equatable {
  const PaymentSelectionState({
    this.loadingStatus = LoadingStatus.idle,
  });

  final LoadingStatus loadingStatus;

  PaymentSelectionState copyWith({
    LoadingStatus? loadingStatus,
  }) {
    return PaymentSelectionState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List<Object?> get props => [loadingStatus];
}
