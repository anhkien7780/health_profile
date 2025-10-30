import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/home/home_cubit.dart';
import 'package:health_profile/ui/pages/home/home_state.dart';
import 'package:health_profile/ui/widgets/app_badge/app_badge.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppDimens.paddingNormal,
      children: [
        SizedBox(width: double.infinity, height: 180, child: Placeholder()),
        SizedBox(
          height: 80,
          child: Row(
            spacing: AppDimens.paddingBig,
            children: [
              Flexible(
                child: AppElevatedButton(
                  onClick: () {},
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
              style: Theme.of(context).textTheme.titleMedium,
            ),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (pre, current) =>
              pre.appointmentsCount != current.appointmentsCount,
              builder: (context, state) {
                return AppBadge(number: state.appointmentsCount);
              },
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => Placeholder(),
          ),
        ),
      ],
    );
  }
}
