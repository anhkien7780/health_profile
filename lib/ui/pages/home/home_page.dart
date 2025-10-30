import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/ui/pages/home/home_cubit.dart';
import 'package:health_profile/ui/pages/home/home_state.dart';
import 'package:health_profile/ui/pages/home/widgets/home_body.dart';
import 'package:health_profile/ui/pages/home/widgets/profile_body.dart';
import 'package:health_profile/ui/widgets/app_bar/base_app_bar.dart';
import 'package:health_profile/ui/widgets/navigation_bar/app_bottom_navigation_bar.dart';

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
      appBar: BaseAppBar(onAlarmActionPressed: () {}),
      bottomNavigationBar: _createBottomNavigationBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingNormal),
        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (pre, current) =>
              pre.selectedPageIndex != current.selectedPageIndex,
          builder: (context, state) {
            return <Widget>[ProfileBody(), HomeBody()][state.selectedPageIndex];
          },
        ),
      ),
    );
  }

  Widget _createBottomNavigationBar() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (pre, current) =>
          pre.selectedPageIndex != current.selectedPageIndex,
      builder: (context, state) {
        return AppBottomNavigationBar(
          selectedPageIndex: state.selectedPageIndex,
          onDestinationPressed: (index) {
            _cubit.onDestinationPressed(index);
          },
        );
      },
    );
  }
}
