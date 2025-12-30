import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/ui/pages/medical_record_list/medical_record_list_cubit.dart';
import 'package:health_profile/ui/pages/medical_record_list/medical_record_list_state.dart';
import 'package:health_profile/ui/pages/medical_record_list/widgets/medical_record_item.dart';
import 'package:health_profile/ui/widgets/app_loading/app_loading.dart';

class MedicalRecordListBody extends StatelessWidget {
  const MedicalRecordListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return BlocBuilder<MedicalRecordListCubit, MedicalRecordListState>(
      builder: (context, state) {
        return AppLoadingOverlay(
          isLoading: state.loadingStatus == LoadingStatus.loading,
          child: Scaffold(
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
                onPressed: () => context.pop(),
              ),
              title: Text(
                s.medicalRecordDetail,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimaryFixed,
                ),
              ),
            ),
            body: _buildContent(state),
          ),
        );
      },
    );
  }

  Widget _buildContent(MedicalRecordListState state) {
    if (state.loadingStatus != LoadingStatus.loading &&
        state.medicalRecords.isEmpty) {
      return const Center(
        child: Text('No medical records found.'),
      );
    }

    return ListView.builder(
      itemCount: state.medicalRecords.length,
      itemBuilder: (context, index) {
        final record = state.medicalRecords[index];
        return MedicalRecordItem(
          record: record,
        );
      },
    );
  }
}
