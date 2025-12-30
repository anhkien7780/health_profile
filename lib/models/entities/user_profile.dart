import 'package:flutter/material.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/enum/gender.dart';

class UserProfile {
  const UserProfile({
    required this.fullName,
    required this.birthDay,
    required this.phoneNumber,
    this.email,
    required this.username,
    required this.gender,
    required this.id,
    required this.userId,
    required this.address,
    this.emergencyContact,
    this.bloodType,
    this.allergies,
  });

  final String fullName;
  final String birthDay;
  final String phoneNumber;
  final String? email;
  final String username;
  final Gender gender;
  final String id;
  final int userId;
  final String address;
  final String? emergencyContact;
  final String? bloodType;
  final String? allergies;

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "dateOfBirth": birthDay,
        "phone": phoneNumber,
        "email": email ?? '',
        "username": username,
        "gender": gender.name.toUpperCase(),
        "id": id,
        "userId": userId,
        "address": address,
        "emergencyContact": emergencyContact ?? '',
        "bloodType": bloodType ?? '',
        "allergies": allergies ?? '',
      };

  List<Map<String, dynamic>> toInfoList(S s) {
    return [
      {"icon": Icons.person_outline, "label": s.fullName, "value": fullName},
      {"icon": Icons.cake_outlined, "label": s.dateOfBirth, "value": birthDay},
      {
        "icon": Icons.phone_outlined,
        "label": s.phoneNumber,
        "value": phoneNumber,
      },
      {
        "icon": Icons.wc_outlined,
        "label": s.gender,
        "value": gender == Gender.male ? s.male : s.female,
      },
      {"icon": Icons.badge, "label": s.id, "value": id},
      {"icon": Icons.place_outlined, "label": s.address, "value": address},
      {
        "icon": Icons.contact_emergency_outlined,
        "label": s.emergencyContact,
        "value": (emergencyContact?.isNotEmpty ?? false)
            ? emergencyContact!
            : s.notAvailable,
      },
      {
        "icon": Icons.bloodtype_outlined,
        "label": s.bloodType,
        "value": (bloodType?.isNotEmpty ?? false) ? bloodType! : s.notAvailable,
      },
      {
        "icon": Icons.warning_amber_outlined,
        "label": s.allergies,
        "value": (allergies?.isNotEmpty ?? false) ? allergies! : s.notAvailable,
      },
    ];
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullName: json["fullName"] ?? '',
      birthDay: json["dateOfBirth"] ?? '',
      phoneNumber: json["phone"] ?? '',
      email: json["email"],
      username: json["username"] ?? json["email"] ?? '',
      gender: (json["gender"] as String? ?? 'MALE').toUpperCase() == 'FEMALE'
          ? Gender.female
          : Gender.male,
      id: (json["patientId"] ?? 0).toString(),
      userId: json["userId"] ?? 0,
      address: json["address"] ?? '',
      emergencyContact: json["emergencyContact"],
      bloodType: json["bloodType"],
      allergies: json["allergies"],
    );
  }

  UserProfile copyWith({
    String? fullName,
    String? birthDay,
    String? phoneNumber,
    String? email,
    String? username,
    Gender? gender,
    String? id,
    int? userId,
    String? address,
    String? emergencyContact,
    String? bloodType,
    String? allergies,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      birthDay: birthDay ?? this.birthDay,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      address: address ?? this.address,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
    );
  }
}
