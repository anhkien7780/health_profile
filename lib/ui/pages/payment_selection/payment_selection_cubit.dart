import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/models/enum/payment_method.dart';
import 'package:health_profile/repositories/payment_repository.dart';
import 'package:health_profile/ui/pages/payment_selection/payment_selection_navigator.dart';
import 'package:health_profile/ui/pages/payment_selection/payment_selection_state.dart';

class PaymentSelectionCubit extends Cubit<PaymentSelectionState> {
  final PaymentRepository paymentRepository;
  final int appointmentId;
  final PaymentSelectionNavigator navigator;

  PaymentSelectionCubit({
    required this.paymentRepository,
    required this.appointmentId,
    required this.navigator,
  }) : super(const PaymentSelectionState());

  Future<void> createPayment(PaymentMethod method) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final transaction = await paymentRepository.createPaymentTransaction(
        appointmentId: appointmentId,
        paymentMethod: method,
      );
      emit(state.copyWith(loadingStatus: LoadingStatus.finish));

      if (transaction.paymentUrl != null) {
        navigator.navigateToWebPayment(transaction.paymentUrl!);
      } else if (transaction.transactionRef != null) {
        navigator.navigateToPaymentResult(transaction.transactionRef!);
      }
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }
}
