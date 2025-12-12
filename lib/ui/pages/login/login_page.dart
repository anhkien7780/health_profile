import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/auth_repository.dart';
import 'package:health_profile/ui/widgets/app_loading/app_loading.dart';
import 'package:health_profile/ui/widgets/auth_base_page/auth_base_page.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';
import 'package:health_profile/ui/widgets/text_fields/app_text_form_field.dart';
import 'package:health_profile/utils/text_validator.dart';

import 'login_cubit.dart';
import 'login_navigator.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) {
        return LoginCubit(
          navigator: LoginNavigator(context),
          authRepository: context.read<AuthRepository>(),
        );
      },
      child: const LoginChildPage(),
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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.loadStatus == LoadingStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return AppLoadingOverlay(
          isLoading: state.loadStatus == LoadingStatus.loading,
          child: AuthBasePage(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingNormal,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: AppDimens.paddingNormal,
                  children: [
                    AppTextFormField(
                      controller: _cubit.emailController,
                      title: S.of(context).emailTitle,
                      hint: S.of(context).emailHint,
                      validator: TextValidator.validateEmail,
                    ),
                    AppTextFormField(
                      controller: _cubit.passwordController,
                      title: S.of(context).passwordTitle,
                      hint: S.of(context).passwordHint,
                      obscureText: true,
                      validator: TextValidator.validatePassword,
                    ),
                    AppElevatedButton(
                      width: double.infinity,
                      height: AppDimens.buttonHeightNormal,
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          _cubit.onSignInButtonPressed();
                        }
                      },
                      text: S.of(context).loginButton,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _cubit.onSignUpButtonPressed();
                          },
                          child: Text(
                            S.of(context).registerAccount,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            _cubit.onForgotPasswordTextPressed();
                          },
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
          ),
        );
      },
    );
  }
}
