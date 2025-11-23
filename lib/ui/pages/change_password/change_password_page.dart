import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/change_password/change_password.dart';
import 'package:health_profile/ui/pages/change_password/change_password_cubit.dart';
import 'package:health_profile/ui/widgets/auth_base_page/auth_base_page.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';
import 'package:health_profile/ui/widgets/text_fields/app_text_form_field.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (context) {
        return ChangePasswordCubit(navigator: ChangePasswordNavigator(context));
      },
      child: ChangePasswordChildPage(),
    );
  }
}

class ChangePasswordChildPage extends StatefulWidget {
  const ChangePasswordChildPage({super.key});

  @override
  State<ChangePasswordChildPage> createState() =>
      _ForgotPasswordChildPageState();
}

class _ForgotPasswordChildPageState extends State<ChangePasswordChildPage> {
  late final ChangePasswordCubit _cubit;
  late final S s;
  @override
  void initState() {
    super.initState();
    _cubit = context.read<ChangePasswordCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    s = S.of(context);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return AuthBasePage(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          spacing: AppDimens.paddingNormal,
          children: [
            AppTextFormField(
              title: s.passwordTitle,
              hint: s.newPasswordHint,
            ),
            AppTextFormField(
              title: s.confirmPasswordTitle,
              hint: s.confirmPasswordHint,
            ),
            AppElevatedButton(
              width: double.infinity,
              height: AppDimens.buttonHeightNormal,
              onClick: () {
                _cubit.onChangePasswordPressed();
              },
              text: s.changePassword,
            ),
          ],
        ),
      ),
    );
  }
}
