import 'package:flutter/material.dart';

class UserProfile {
  const UserProfile({
    required this.fullName,
    required this.birthDay,
    required this.phoneNumber,
    this.email,
    required this.username,
    required this.gender,
    required this.id,
    required this.address,
  });

  final String fullName;
  final String birthDay;
  final String phoneNumber;
  final String? email;
  final String username;
  final String gender;
  final String id;
  final String address;

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "birth_day": birthDay,
    "phone_number": phoneNumber,
    "email": email,
    "username": username,
    "gender": gender,
    "id": id,
    "address": address,
  };

  List<Map<String, dynamic>> toInfoList() {
    return [
      {"icon": Icons.person_outline, "label": "Full Name", "value": fullName},
      {"icon": Icons.cake_outlined, "label": "Birth Day", "value": birthDay},
      {
        "icon": Icons.phone_outlined,
        "label": "Phone Number",
        "value": phoneNumber,
      },
      {"icon": Icons.email_outlined, "label": "Email", "value": email ?? "N/A"},
      {
        "icon": Icons.account_circle_outlined,
        "label": "Username",
        "value": username,
      },
      {"icon": Icons.wc_outlined, "label": "Gender", "value": gender},
      {"icon": Icons.badge, "label": "ID", "value": id},
      {"icon": Icons.place_outlined, "label": "Address", "value": address},
    ];
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    fullName: json["full_name"],
    birthDay: json["birth_day"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    username: json["username"],
    gender: json["gender"],
    id: json["id"],
    address: json["address"],
  );

  UserProfile copyWith({
    String? fullName,
    String? birthDay,
    String? phoneNumber,
    String? email,
    String? username,
    String? gender,
    String? id,
    String? address,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      birthDay: birthDay ?? this.birthDay,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      address: address ?? this.address,
    );
  }
}
