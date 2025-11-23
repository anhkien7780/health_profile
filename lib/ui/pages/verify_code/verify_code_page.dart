import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/verify_code/verify_code_cubit.dart';
import 'package:health_profile/ui/pages/verify_code/verify_code_navigator.dart';
import 'package:health_profile/ui/widgets/auth_base_page/auth_base_page.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';
import 'package:health_profile/ui/widgets/text_fields/app_text_form_field.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerifyCodeCubit>(
      create: (context) {
        return VerifyCodeCubit(navigator: VerifyCodeNavigator(context));
      },
      child: VerifyCodeChildPage(),
    );
  }
}

class VerifyCodeChildPage extends StatefulWidget {
  const VerifyCodeChildPage({super.key});

  @override
  State<VerifyCodeChildPage> createState() => _VerifyCodeChildPageState();
}

class _VerifyCodeChildPageState extends State<VerifyCodeChildPage> {
  late final VerifyCodeCubit _cubit;
  late final S s;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<VerifyCodeCubit>();
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
            Row(
              spacing: AppDimens.paddingSmall,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: AppTextFormField(
                    title: s.verifyTitle,
                    hint: s.verifyHint,
                  ),
                ),
                AppElevatedButton(
                  onClick: () {},
                  text: s.resend,
                  height: AppDimens.buttonHeightSmall,
                ),
              ],
            ),
            AppElevatedButton(
              onClick: () {
                _cubit.onConfirmPressed();
              },
              text: s.confirm,
              width: double.infinity,
              height: AppDimens.buttonHeightNormal,
            ),
            GestureDetector(
              onTap: () {
                _cubit.onBackButtonPressed();
              },
              child: Text(s.backToLogin),
            ),
          ],
        ),
      ),
    );
  }
}
