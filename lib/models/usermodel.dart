// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String uid;
  final bool isVerified;
  final String name;
  final String fcm;
  final String email;
  final String address;
  final String profilePic;
  final int balance;
  final int rewardPoints;
  UserModel({
    required this.uid,
    required this.isVerified,
    required this.name,
    required this.fcm,
    required this.email,
    required this.address,
    required this.profilePic,
    required this.balance,
    required this.rewardPoints,
  });

  UserModel copyWith({
    String? uid,
    bool? isVerified,
    String? name,
    String? fcm,
    String? email,
    String? address,
    String? profilePic,
    int? balance,
    int? rewardPoints,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      isVerified: isVerified ?? this.isVerified,
      name: name ?? this.name,
      fcm: fcm ?? this.fcm,
      email: email ?? this.email,
      address: address ?? this.address,
      profilePic: profilePic ?? this.profilePic,
      balance: balance ?? this.balance,
      rewardPoints: rewardPoints ?? this.rewardPoints,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'isVerified': isVerified,
      'name': name,
      'fcm': fcm,
      'email': email,
      'address': address,
      'profilePic': profilePic,
      'balance': balance,
      'rewardPoints': rewardPoints,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      isVerified: map['isVerified'] as bool,
      name: map['name'] as String,
      fcm: map['fcm'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      profilePic: map['profilePic'] as String,
      balance: map['balance'] as int,
      rewardPoints: map['rewardPoints'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, isVerified: $isVerified, name: $name, fcm: $fcm, email: $email, address: $address, profilePic: $profilePic, balance: $balance, rewardPoints: $rewardPoints)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.isVerified == isVerified &&
      other.name == name &&
      other.fcm == fcm &&
      other.email == email &&
      other.address == address &&
      other.profilePic == profilePic &&
      other.balance == balance &&
      other.rewardPoints == rewardPoints;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      isVerified.hashCode ^
      name.hashCode ^
      fcm.hashCode ^
      email.hashCode ^
      address.hashCode ^
      profilePic.hashCode ^
      balance.hashCode ^
      rewardPoints.hashCode;
  }
}
