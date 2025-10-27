import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/ui/pages/home/home_cubit.dart';

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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 1),
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
        ),
        margin: EdgeInsets.all(AppDimens.marginNormal),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
          child: NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: "Text"),
              NavigationDestination(icon: Icon(Icons.home), label: "Text"),
              NavigationDestination(icon: Icon(Icons.home), label: "Text"),
              NavigationDestination(icon: Icon(Icons.home), label: "Text"),
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
