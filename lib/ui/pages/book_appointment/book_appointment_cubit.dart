import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_navigator.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_state.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  BookAppointmentCubit({required this.navigator})
      : super(const BookAppointmentState());

  final BookAppointmentNavigator navigator;
}
