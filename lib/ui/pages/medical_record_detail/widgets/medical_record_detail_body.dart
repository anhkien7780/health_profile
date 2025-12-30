import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/entities/prescription_item.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/ui/pages/medical_record_detail/medical_record_detail_cubit.dart';
import 'package:health_profile/ui/pages/medical_record_detail/medical_record_detail_state.dart';
import 'package:health_profile/ui/widgets/app_loading/app_loading.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';

class MedicalRecordDetailBody extends StatelessWidget {
  const MedicalRecordDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return BlocBuilder<MedicalRecordDetailCubit, MedicalRecordDetailState>(
      builder: (context, state) {
        return AppLoadingOverlay(
          isLoading: state.loadingStatus == LoadingStatus.loading,
          child: Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
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
            body: _buildContent(context, state),
          ),
        );
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<MedicalRecordDetailCubit, MedicalRecordDetailState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: AppElevatedButton(
                onClick: () {},
                text: s.chatWithDoctor,
              ),
            ),
            const SizedBox(width: AppDimens.paddingMedium),
            Expanded(
              child: AppElevatedButton(
                onClick: () {
                  context.read<MedicalRecordDetailCubit>().checkPaymentStatusAndNavigate();
                },
                text: s.payment,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, MedicalRecordDetailState state) {
    final record = state.medicalRecord;
    final prescription = state.prescription;
    final s = S.of(context);
    final theme = Theme.of(context);

    if (record == null) {
      return Center(child: Text(s.noDetailToDisplay));
    }

    return ListView(
      padding: const EdgeInsets.all(AppDimens.paddingMedium),
      children: [
        _buildSectionHeader(theme, s.medicalRecord),
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.paddingNormal),
            child: Column(
              children: [
                _buildInfoRow(theme, s.medicalRecordDate, record.recordDate),
                const Divider(),
                _buildInfoRow(theme, s.medicalRecordSymptoms, record.symptoms),
                const Divider(),
                _buildInfoRow(theme, s.medicalRecordDiagnosis, record.diagnosis),
                const Divider(),
                _buildInfoRow(theme, s.medicalRecordTreatment, record.treatment),
                if (record.notes != null && record.notes!.isNotEmpty) ...[
                  const Divider(),
                  _buildInfoRow(theme, s.medicalRecordNotes, record.notes!),
                ]
              ],
            ),
          ),
        ),
        if (prescription != null && prescription.items.isNotEmpty) ...[
          const SizedBox(height: AppDimens.paddingBig),
          _buildSectionHeader(theme, s.prescription),
          ...prescription.items
              .map((item) => _buildPrescriptionItem(theme, s, item)),
        ],
        const SizedBox(height: AppDimens.paddingBig),
        _buildButtons(context),
      ],
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppDimens.paddingSmall, bottom: AppDimens.paddingSmall),
      child: Text(
        title,
        style: theme.textTheme.headlineSmall,
      ),
    );
  }

  Widget _buildInfoRow(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppDimens.paddingSmall),
          Expanded(
            flex: 3,
            child: Text(value, style: theme.textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionItem(ThemeData theme, S s, PrescriptionItem item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                item.medicineName,
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: AppDimens.paddingNormal),
            _buildInfoRow(theme, s.dosage, item.dosage),
            const Divider(),
            _buildInfoRow(theme, s.frequency, item.frequency),
            const Divider(),
            _buildInfoRow(theme, s.duration, item.duration),
            const Divider(),
            _buildInfoRow(theme, s.quantity, item.quantity.toString()),
            const Divider(),
            _buildInfoRow(theme, s.instructions, item.instructions),
          ],
        ),
      ),
    );
  }
}
