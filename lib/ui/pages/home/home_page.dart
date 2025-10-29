import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/common/app_images.dart';
import 'package:health_profile/ui/pages/home/home_cubit.dart';
import 'package:health_profile/ui/pages/home/widgets/destination_item.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppbar(context),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 1),
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
        ),
        margin: EdgeInsets.all(AppDimens.marginNormal),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
          child: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: const [
              DestinationItem(
                icon: Icons.account_circle_outlined,
                label: "Profile",
              ),
              DestinationItem(icon: Icons.home, label: "Home"),
              DestinationItem(icon: Icons.message_outlined, label: "Chat"),
              DestinationItem(icon: Icons.settings_outlined, label: "Settings"),
            ],
            height: AppDimens.navigationBarHeight,
            labelTextStyle: WidgetStatePropertyAll(
              Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

AppBar createAppbar(BuildContext context) {
  return AppBar(
    leadingWidth: AppDimens.paddingNormal + AppDimens.logoSizeSmall,
    toolbarHeight: AppDimens.paddingSmall * 2 + AppDimens.logoSizeSmall,
    leading: Padding(
      padding: const EdgeInsets.only(
        top: AppDimens.paddingSmall,
        left: AppDimens.paddingNormal,
        bottom: AppDimens.paddingSmall,
      ),
      child: Image.asset(
        width: AppDimens.logoSizeSmall,
        height: AppDimens.logoSizeSmall,
        AppImages.icLogo,
      ),
    ),
    title: Text(
      "Health Profile",
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}
