import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/appointment_repository.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_navigator.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_state.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_hospital_step/choose_hospital_step_page.dart';
import 'package:health_profile/ui/pages/book_appointment/widgets/choose_schedule_step_content.dart';
import 'package:health_profile/ui/widgets/app_loading/app_loading.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';

class BookAppointmentPage extends StatelessWidget {
  const BookAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookAppointmentCubit(
        navigator: BookAppointmentNavigator(context),
        appointmentRepository: context.read<AppointmentRepository>(),
      ),
      child: const BookAppointmentChildPage(),
    );
  }
}

class BookAppointmentChildPage extends StatefulWidget {
  const BookAppointmentChildPage({super.key});

  @override
  State<BookAppointmentChildPage> createState() =>
      _BookAppointmentChildPageState();
}

class _BookAppointmentChildPageState extends State<BookAppointmentChildPage> {
  late final BookAppointmentCubit _cubit;
  late final ThemeData theme;
  late final S s;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<BookAppointmentCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    s = S.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
      buildWhen: (pre, current) => pre.loadingStatus != current.loadingStatus,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: _createAppBar(),
          body: _createBody(),
        );
      },
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppDimens.borderRadiusBig),
          bottomRight: Radius.circular(AppDimens.borderRadiusBig),
        ),
      ),
      backgroundColor: theme.colorScheme.primaryFixedDim,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: _cubit.onBackPressed,
      ),
      title: Text(
        s.bookAppointment,
        style: theme.textTheme.titleLarge?.copyWith(
          color: theme.colorScheme.onPrimaryFixed,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          color: theme.colorScheme.onPrimaryFixed,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _createBody() {
    return BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
      buildWhen: (pre, current) => pre.currentStep != current.currentStep,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppDimens.paddingBig),
          child: Column(
            spacing: AppDimens.paddingBig,
            children: [
              _createStepIndicator(state.currentStep),
              _createBodyContent(),
              _createButtonNextButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _createBodyContent() {
    return Expanded(
      child: PageView(
        controller: _cubit.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          _cubit.changeStep(index);
        },
        children: [
          ChooseHospitalStepPage(),
          ChooseScheduleStepContent(),
          _buildPlaceholderStep(context, s.confirmAppointment),
        ],
      ),
    );
  }

  Widget _createButtonNextButton() {
    return AppElevatedButton(
      width: double.infinity,
      height: AppDimens.buttonHeightExtraSmall,
      text: _cubit.state.currentStep == 2 ? s.completed : s.continueStep,
      onClick: _cubit.onNextPressed,
    );
  }

  Widget _buildPlaceholderStep(BuildContext context, String title) {
    return Center(child: Text(title));
  }

  Widget _createStepIndicator(int currentStep) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStepItem(index: 1, title: s.chooseHospital),
        _buildStepItem(index: 2, title: s.chooseSchedule),
        _buildStepItem(index: 3, title: s.confirmAppointment),
      ],
    );
  }

  Widget _buildStepItem({required int index, required String title}) {
    final isActive = _cubit.isActive(index);
    final color = isActive
        ? theme.colorScheme.primary
        : theme.colorScheme.surfaceContainerHighest;
    final textColor = isActive
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurfaceVariant;

    return SizedBox(
      width: AppDimens.stepItemWidth,
      child: Column(
        spacing: AppDimens.paddingSmallest,
        children: [
          Container(
            width: AppDimens.circle40,
            height: AppDimens.circle40,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Text(
              index.toString(),
              style: theme.textTheme.titleLarge?.copyWith(color: textColor),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
