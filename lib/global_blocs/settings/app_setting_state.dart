import 'package:equatable/equatable.dart';
import 'package:health_profile/models/enum/language.dart';

class AppSettingState extends Equatable {
  const AppSettingState({required this.currentLanguage});

  final Language currentLanguage;

  AppSettingState copyWith({
    Language? currentLanguage,
  }) {
    return AppSettingState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
    );
  }

  @override
  List<Object> get props => [currentLanguage];
}
