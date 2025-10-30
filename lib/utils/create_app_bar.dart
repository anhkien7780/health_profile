import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/common/app_images.dart';

AppBar createAppbar(BuildContext context, {required VoidCallback onAlarmActionPressed}) {
  return AppBar(
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
    actions: [
      IconButton(
        onPressed: () {
          onAlarmActionPressed();
        },
        icon: Icon(Icons.notifications),
      ),
    ],
    title: Text("Health Profile"),
  );
}
