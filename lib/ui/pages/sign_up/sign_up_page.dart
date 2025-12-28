import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/auth_repository.dart';
import 'package:health_profile/ui/pages/sign_up/sign_up_cubit.dart';
import 'package:health_profile/ui/pages/sign_up/sign_up_navigator.dart';
import 'package:health_profile/ui/pages/sign_up/sign_up_state.dart';
import 'package:health_profile/ui/widgets/auth_base_page/auth_base_page.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';
import 'package:health_profile/ui/widgets/snack_bar/app_snackbar.dart';
import 'package:health_profile/ui/widgets/text_fields/app_text_form_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (BuildContext context) {
        return SignUpCubit(
          navigator: SignUpNavigator(context),
          authRepository: AuthRepositoryImpl(),
        );
      },
      child: const SignUpChildPage(),
    );
  }
}

class SignUpChildPage extends StatelessWidget {
  const SignUpChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == LoadingStatus.error) {
          AppSnackBar.show(
            context,
            state.errorMessage ?? S.of(context).errorOccurred,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AuthBasePage(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingNormal,
              ),
              child: Column(
                spacing: AppDimens.paddingNormal,
                children: [
                  AppTextFormField(
                    controller: cubit.emailController,
                    title: S.of(context).emailTitle,
                    hint: S.of(context).emailHint,
                  ),
                  AppTextFormField(
                    controller: cubit.passwordController,
                    title: S.of(context).passwordTitle,
                    hint: S.of(context).passwordHint,
                    obscureText: true,
                  ),
                  AppTextFormField(
                    controller: cubit.confirmPasswordController,
                    title: S.of(context).confirmPasswordTitle,
                    hint: S.of(context).confirmPasswordHint,
                    obscureText: true,
                  ),
                  AppElevatedButton(
                    width: double.infinity,
                    height: AppDimens.buttonHeightNormal,
                    onClick: () {
                      cubit.onRegisterButtonPressed();
                    },
                    text: S.of(context).registerButton,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        cubit.openLoginPage();
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
      },
    );
  }
}
