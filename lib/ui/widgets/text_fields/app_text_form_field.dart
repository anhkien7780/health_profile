import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.title,
    this.hint,
    this.readOnly = false,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.width,
    this.maxLines = 1,
    this.onChanged,
  });

  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final VoidCallback? onTap;
  final String title;
  final double? width;
  final String? hint;
  final bool obscureText;
  final bool readOnly;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimens.paddingSmall,
      children: [
        if (title.isNotEmpty)
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(
          width: width ?? double.infinity,
          height: maxLines == 1 ? AppDimens.textFieldHeight : null,
          child: TextFormField(
            readOnly: readOnly,
            validator: validator,
            controller: controller,
            obscureText: obscureText,
            onTap: onTap,
            maxLines: maxLines,
            onChanged: onChanged,
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
