import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/common/app_images.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/splash_page/splash_cubit.dart';
import 'package:health_profile/ui/pages/splash_page/splash_navigator.dart';
import 'package:health_profile/ui/pages/splash_page/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(navigator: SplashNavigator(context)),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return SplashChildPage();
        },
      ),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({super.key});

  @override
  State<SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late final SplashCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SplashCubit>();
    _cubit.openOnboardingPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: AppDimens.marginNormal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.icLogo,
              width: AppDimens.logoSize.width,
              height: AppDimens.logoSize.height,
            ),
            Text(
              S.of(context).appName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
