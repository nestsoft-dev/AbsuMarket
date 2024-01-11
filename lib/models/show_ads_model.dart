import 'package:cloud_firestore/cloud_firestore.dart';

class ShowAdsModel {
  final String imageUrl;
  final String storeId;
  final Timestamp time;

  ShowAdsModel({
    required this.imageUrl,
    required this.storeId,
    required this.time,
  });

  factory ShowAdsModel.fromMap(Map<String, dynamic> map) {
    return ShowAdsModel(
      imageUrl: map['imageUrl'],
      storeId: map['storeId'],
      time:
          map['time'], // Assuming 'time' is stored as a Timestamp in Firestore
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'storeId': storeId,
      'time': time,
    };
  }
}
