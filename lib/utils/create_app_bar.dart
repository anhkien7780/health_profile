import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/common/app_images.dart';

AppBar createAppbar(BuildContext context) {
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
      IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
    ],
    title: Text(
      "Health Profile",
    ),
  );
}