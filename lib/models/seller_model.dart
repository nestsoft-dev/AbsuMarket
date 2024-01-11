import 'package:cloud_firestore/cloud_firestore.dart';

class SellerModel {
  final String name;
  final String email;
  final String storeName;
  final String uuid;
  final String fcm;
  final bool isValid ;
  final String storeBannerImage;
  final String profilePic;
  final Timestamp buyLicencesDate;
  final double balance;
  final int totalSells;
  final int pendingOrders;
  final int rewardsPoints;

  SellerModel({
    required this.name,
    required this.email,
    required this.storeName,
    required this.uuid,
    required this.fcm,
    required this.isValid ,
    required this.storeBannerImage,
    required this.profilePic,
    required this.buyLicencesDate,
    required this.balance,
    required this.totalSells,
    required this.pendingOrders,
    required this.rewardsPoints,
  });

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      storeName: map['storeName'] ?? '',
      uuid: map['uuid'] ?? '',
      fcm: map['fcm'] ?? '',
      isValid: map['isValid'] ?? false,
      storeBannerImage: map['storeBannerImage'] ?? '',
      profilePic: map['profilePic'] ?? '',
      buyLicencesDate: map['buyLicencesDate'] ?? Timestamp.now(),
      balance: (map['balance'] ?? 0.0).toDouble(),
      totalSells: map['totalSells'] ?? 0,
      pendingOrders: map['pendingOrders'] ?? 0,
      rewardsPoints: map['rewardsPoints'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'storeName': storeName,
      'uuid': uuid,
      'fcm': fcm,
      'isValid': isValid,
      'storeBannerImage': storeBannerImage,
      'profilePic': profilePic,
      'buyLicencesDate': buyLicencesDate,
      'balance': balance,
      'totalSells': totalSells,
      'pendingOrders': pendingOrders,
      'rewardsPoints': rewardsPoints,
    };
  }
}
