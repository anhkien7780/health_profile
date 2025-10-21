import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.onClick,
    required this.text,
    this.width = double.infinity,
    this.height = AppDimens.buttonHeightNormal,
    this.borderRadius = AppDimens.borderRadiusNormal,
  });

  final VoidCallback onClick;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppDimens.borderRadiusNormal,
            ),
          ),
        ),
        onPressed: () => onClick(),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
