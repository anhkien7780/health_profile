import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/widgets/auth_base_screen/auth_base_screen.dart';
import 'package:health_profile/ui/widgets/buttons/app_outlined_button.dart';
import 'package:health_profile/ui/widgets/text_fileds/app_text_form_field.dart';

import 'login_cubit.dart';
import 'login_navigator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) {
        return LoginCubit(navigator: LoginNavigator(context));
      },
      child: LoginChildPage(),
    );
  }
}

class LoginChildPage extends StatefulWidget {
  const LoginChildPage({super.key});

  @override
  State<LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<LoginChildPage> {

  late final LoginCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBaseScreen(
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
              AppElevatedButton(
                onClick: () {
                  _cubit.openHomePage();
                },
                text: S.of(context).loginButton,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      _cubit.navigator.openSignUpPage();
                    },
                    child: Text(
                      S.of(context).registerAccount,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      S.of(context).forgetPassword,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
