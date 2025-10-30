import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.title,
    this.hint,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
  });

  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final VoidCallback? onTap;
  final String title;
  final String? hint;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimens.paddingSmall,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(
          width: double.infinity,
          height: AppDimens.textFieldHeight,
          child: TextFormField(
            validator: validator,
            controller: controller,
            obscureText: obscureText,
            onTap: onTap,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hint: Text(
                hint ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppDimens.borderRadiusSmall,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
