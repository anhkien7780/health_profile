import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/sign_up/sign_up_cubit.dart';
import 'package:health_profile/ui/pages/sign_up/sign_up_navigator.dart';
import 'package:health_profile/ui/widgets/auth_base_page/auth_base_page.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';
import 'package:health_profile/ui/widgets/text_fileds/app_text_form_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (BuildContext context) {
        return SignUpCubit(navigator: SignUpNavigator(context));
      },
      child: SignUpChildPage(),
    );
  }
}

class SignUpChildPage extends StatefulWidget {
  const SignUpChildPage({super.key});

  @override
  State<SignUpChildPage> createState() => _SignUpChildPageState();
}

class _SignUpChildPageState extends State<SignUpChildPage> {

  late final SignUpCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SignUpCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBasePage(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingNormal,
        ),
        child: Form(
          child: Column(
            spacing: AppDimens.paddingNormal,
            children: [
              AppTextFormField(
                title: S.of(context).emailTitle,
                hint: S.of(context).emailHint,
              ),
              AppTextFormField(
                title: S.of(context).passwordTitle,
                hint: S.of(context).passwordHint,
                obscureText: true,
              ),
              AppTextFormField(
                title: S.of(context).confirmPasswordTitle,
                hint: S.of(context).confirmPasswordHint,
                obscureText: true,
              ),
              AppElevatedButton(
                onClick: () {},
                text: S.of(context).registerButton,
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    _cubit.openLoginPage();
                  },
                  child: Text(
                    S.of(context).backToLogin,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
