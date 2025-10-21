import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/common/app_images.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/widgets/buttons/app_outlined_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_cubit.dart';
import 'onboarding_state.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (context) => OnboardingCubit(),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return OnboardingChildPage();
        },
      ),
    );
  }
}

class OnboardingChildPage extends StatefulWidget {
  const OnboardingChildPage({super.key});

  @override
  State<OnboardingChildPage> createState() => _OnboardingChildPageState();
}

class _OnboardingChildPageState extends State<OnboardingChildPage> {
  late final OnboardingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<OnboardingCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.marginNormal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<OnboardingCubit, OnboardingState>(
                buildWhen: (previous, current) =>
                    previous.currentPage != current.currentPage,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(AppDimens.marginNormal),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          _cubit.onSkip();
                        },
                        child: Opacity(
                          opacity: state.currentPage == 2 ? 0 : 1,
                          child: Text(
                            S.of(context).skip,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: screenHeight * 0.7,
                child: PageView(
                  controller: _cubit.pageController,
                  onPageChanged: (index) {
                    _cubit.updatePage(index);
                  },
                  children: [
                    OnboardingPageViewChild(
                      svgImagePath: AppImages.iPlaceHolder,
                      headline: S.of(context).onboardingFirstHeadline,
                      detail: S.of(context).onBoardingFirstDetail,
                    ),
                    OnboardingPageViewChild(
                      svgImagePath: AppImages.iPlaceHolder,
                      headline: S.of(context).onBoardingSecondHeadline,
                      detail: S.of(context).onBoardingSecondDetail,
                    ),
                    OnboardingPageViewChild(
                      svgImagePath: AppImages.iPlaceHolder,
                      headline: S.of(context).onBoardingThirdHeadline,
                      detail: S.of(context).onBoardingThirdDetail,
                    ),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: _cubit.pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 4,
                  spacing: 2,
                  dotWidth: 10,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: AppDimens.marginBigger),
                child: AppElevatedButton(
                  onClick: () async {
                    await _cubit.nextPage();
                  },
                  text: _cubit.state.currentPage == 2
                      ? S.of(context).getStarted
                      : S.of(context).next,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageViewChild extends StatelessWidget {
  const OnboardingPageViewChild({
    super.key,
    required this.svgImagePath,
    required this.headline,
    required this.detail,
  });

  final String svgImagePath;
  final String headline;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          svgImagePath,
          width: AppDimens.onboardingImageSize.width,
          height: AppDimens.onboardingImageSize.height,
        ),
        SizedBox(height: AppDimens.marginBig),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppDimens.marginSmall,
          children: [
            Text(
              headline,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Text(
              detail,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
