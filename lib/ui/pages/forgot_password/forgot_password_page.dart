import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/forgot_password/forgot_password_cubit.dart';
import 'package:health_profile/ui/widgets/auth_base_page/auth_base_page.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';
import 'package:health_profile/ui/widgets/text_fields/app_text_form_field.dart';

import 'forgot_password_navigator.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (context) {
        return ForgotPasswordCubit(navigator: ForgotPasswordNavigator(context));
      },
      child: ForgotPasswordChildPage(),
    );
  }
}

class ForgotPasswordChildPage extends StatefulWidget {
  const ForgotPasswordChildPage({super.key});

  @override
  State<ForgotPasswordChildPage> createState() =>
      _ForgotPasswordChildPageState();
}

class _ForgotPasswordChildPageState extends State<ForgotPasswordChildPage> {
  late final ForgotPasswordCubit _cubit;
  late final S s;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ForgotPasswordCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    s = S.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return AuthBasePage(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          spacing: AppDimens.paddingNormal,
          children: [
            AppTextFormField(title: s.email, hint: s.emailHint),
            AppElevatedButton(
              width: double.infinity,
              height: AppDimens.buttonHeightNormal,
              onClick: () async {
                await _cubit.onSendVerifyCodePressed();
              },
              text: s.emailHint,
            ),
            GestureDetector(
              onTap: () {
                _cubit.onBackButtonPressed();
              },
              child: Text(
                s.backToLogin,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
