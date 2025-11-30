import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_navigator.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';

class BookAppointmentPage extends StatelessWidget {
  const BookAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookAppointmentCubit(
        navigator: BookAppointmentNavigator(context),
      ),
      child: const BookAppointmentChildPage(),
    );
  }
}

class BookAppointmentChildPage extends StatefulWidget {
  const BookAppointmentChildPage({super.key});

  @override
  State<BookAppointmentChildPage> createState() =>
      _BookAppointmentChildPageState();
}

class _BookAppointmentChildPageState extends State<BookAppointmentChildPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Handle completion
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppDimens.borderRadiusBig),
            bottomRight: Radius.circular(AppDimens.borderRadiusBig),
          ),
        ),
        backgroundColor: theme.colorScheme.primaryFixedDim,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            if (_currentIndex > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          "Đặt lịch khám",
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimaryFixed,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            color: theme.colorScheme.onPrimaryFixed,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingBig),
        child: Column(
          children: [
            _buildStepIndicator(context),
            const SizedBox(height: AppDimens.paddingBig),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  _buildStep1Content(context),
                  _buildPlaceholderStep(context, "Chọn lịch khám"),
                  _buildPlaceholderStep(context, "Xác nhận"),
                ],
              ),
            ),
            AppElevatedButton(
              width: double.infinity,
              height: AppDimens.buttonHeightExtraSmall,
              text: _currentIndex == 2 ? "Hoàn thành" : "Tiếp tục",
              onClick: _onNextPressed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1Content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCardButton(
            context: context,
            iconData: Icons.medical_services,
            title: "Chọn bệnh viện",
            subtitle: "Chọn khoa khám, hệ thống sẽ gợi ý bác sỹ phù hợp nhất",
            onTap: () {},
          ),
          const SizedBox(height: AppDimens.paddingNormal),
          _buildCardButton(
            context: context,
            iconData: Icons.person_search,
            title: "Chọn bác sĩ",
            subtitle: "Chọn trực tiếp bác sỹ mong muốn khám",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderStep(BuildContext context, String title) {
    return Center(
      child: Text(title),
    );
  }

  Widget _buildStepIndicator(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStepItem(
          context,
          "1",
          "Chọn bệnh viện",
          isActive: _currentIndex >= 0,
          isCurrent: _currentIndex == 0,
        ),
        _buildStepItem(
          context,
          "2",
          "Chọn lịch khám",
          isActive: _currentIndex >= 1,
          isCurrent: _currentIndex == 1,
        ),
        _buildStepItem(
          context,
          "3",
          "Xác nhận",
          isActive: _currentIndex >= 2,
          isCurrent: _currentIndex == 2,
        ),
      ],
    );
  }

  Widget _buildStepItem(
    BuildContext context,
    String index,
    String title, {
    required bool isActive,
    required bool isCurrent,
  }) {
    final theme = Theme.of(context);
    // Logic màu sắc:
    // - Đã qua hoặc đang chọn: primary
    // - Chưa đến: surfaceContainerHighest
    final color = isActive
        ? theme.colorScheme.primary
        : theme.colorScheme.surfaceContainerHighest;
    final textColor = isActive
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurfaceVariant;
    
    return SizedBox(
      width: AppDimens.stepItemWidth,
      child: Column(
        children: [
          Container(
            width: AppDimens.circle40,
            height: AppDimens.circle40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Text(
              index,
              style: theme.textTheme.titleLarge?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isActive
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardButton({
    required BuildContext context,
    required IconData iconData,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
      child: Container(
        height: AppDimens.buttonBookMethodHeight,
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
        ),
        child: Row(
          spacing: AppDimens.paddingNormal,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.paddingSmall),
              decoration: BoxDecoration(
                color: theme.colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(
                  AppDimens.borderRadiusNormal,
                ),
              ),
              child: Icon(
                iconData,
                size: AppDimens.iconSizeNormal,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            Expanded(
              child: Column(
                spacing: AppDimens.paddingSmallest,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onPrimary
                          .withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
