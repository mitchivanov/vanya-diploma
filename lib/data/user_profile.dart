import 'dart:convert';

class UserProfile {
  String firstName;
  String lastName;
  String gender;
  String birthday;
  String? photoPath;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthday,
    this.photoPath,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'gender': gender,
    'birthday': birthday,
    'photoPath': photoPath,
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    gender: json['gender'] ?? '',
    birthday: json['birthday'] ?? '',
    photoPath: json['photoPath'],
  );

  static UserProfile empty() => UserProfile(
    firstName: '',
    lastName: '',
    gender: '',
    birthday: '',
    photoPath: null,
  );

  String toRawJson() => jsonEncode(toJson());
  factory UserProfile.fromRawJson(String str) => UserProfile.fromJson(jsonDecode(str));
} 