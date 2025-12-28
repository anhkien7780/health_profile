import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/router/router_config.dart';
import 'package:health_profile/ui/pages/home/home_cubit.dart';
import 'package:health_profile/ui/pages/home/home_state.dart';
import 'package:health_profile/ui/pages/home/widgets/appointment_item.dart';
import 'package:health_profile/ui/widgets/app_badge/app_badge.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      spacing: AppDimens.paddingNormal,
      children: [
        SizedBox(width: double.infinity, height: 180, child: Placeholder()),
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppDimens.paddingBig,
            children: [
              Flexible(
                child: AppElevatedButton(
                  onClick: () {
                    context.pushNamed(AppRouter.bookAppointment);
                  },
                  height: AppDimens.buttonHeightBig,
                  icon: Icon(
                    Icons.pending_actions,
                    size: AppDimens.iconSizeNormal,
                  ),
                  text: S.of(context).bookAppointment,
                ),
              ),
              Flexible(
                child: AppElevatedButton(
                  onClick: () {},
                  height: AppDimens.buttonHeightBig,
                  icon: Icon(Icons.search, size: AppDimens.iconSizeNormal),
                  text: S.of(context).diagnoseDisease,
                ),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppDimens.paddingSmall,
          children: [
            Text(
              S.of(context).appointments,
              style: theme.textTheme.titleMedium,
            ),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (pre, current) =>
                  pre.appointments.length != current.appointments.length,
              builder: (context, state) {
                return AppBadge(number: state.appointments.length);
              },
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                previous.appointments != current.appointments,
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.appointments.length,
                itemBuilder: (context, index) {
                  final appointment = state.appointments[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: AppDimens.paddingSmall),
                    child: AppointmentItem(
                      orderNumber: appointment.orderNumber,
                      hospitalName: appointment.hospitalName,
                      time: appointment.time,
                      doctorName: appointment.doctorName,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
