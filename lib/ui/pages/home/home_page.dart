import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/ui/pages/home/home_cubit.dart';
import 'package:health_profile/ui/pages/home/home_state.dart';
import 'package:health_profile/ui/pages/home/widgets/destination_item.dart';
import 'package:health_profile/ui/widgets/app_badge/app_badge.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';
import 'package:health_profile/utils/create_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key});

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppbar(context, onAlarmActionPressed: () {}),
      bottomNavigationBar: _createBottomNavigationBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingNormal),
        child: Column(
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
                      text: "Book an appointment",
                    ),
                  ),
                  Flexible(
                    child: AppElevatedButton(
                      onClick: () {},
                      height: AppDimens.buttonHeightBig,
                      icon: Icon(Icons.search, size: AppDimens.iconSizeNormal),
                      text: "Diagnose a disease",
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
                  "Appointments",
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
        ),
      ),
    );
  }

  Widget _createBottomNavigationBar() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (pre, current) {
        return pre.selectedPageIndex != current.selectedPageIndex;
      },
      builder: (BuildContext context, HomeState state) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 1),
            borderRadius: BorderRadius.circular(AppDimens.borderRadiusBig),
          ),
          margin: EdgeInsets.all(AppDimens.marginNormal),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.borderRadiusBig),
            child: NavigationBar(
              onDestinationSelected: (index) {
                _cubit.onDestinationPressed(index);
              },
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: _cubit.state.selectedPageIndex,
              destinations: const [
                DestinationItem(
                  icon: Icons.account_circle_outlined,
                  label: "Profile",
                ),
                DestinationItem(icon: Icons.home, label: "Home"),
                DestinationItem(icon: Icons.message_outlined, label: "Chat"),
                DestinationItem(
                  icon: Icons.settings_outlined,
                  label: "Settings",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
