import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/home/widgets/destination_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.selectedPageIndex,
    required this.onDestinationPressed,
  });

  final int selectedPageIndex;
  final Function(int index) onDestinationPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent, width: 1),
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusBig),
      ),
      margin: EdgeInsets.all(AppDimens.marginNormal),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusBig),
        child: NavigationBar(
          onDestinationSelected: (index) => onDestinationPressed(index),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: selectedPageIndex,
          destinations: [
            DestinationItem(
              icon: Icons.account_circle_outlined,
              label: S.of(context).profile,
            ),
            DestinationItem(icon: Icons.home, label: S.of(context).home),
            DestinationItem(
              icon: Icons.message_outlined,
              label: S.of(context).chat,
            ),
            DestinationItem(
              icon: Icons.settings_outlined,
              label: S.of(context).settings,
            ),
          ],
        ),
      ),
    );
  }
}
