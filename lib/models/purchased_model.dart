// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PurchasedModel {
  final String imageUrl;
  final String productName;
  final String storeName;
  final String date;
  final String rateText;
  final String myId;
  final String storeId;
  final String location;

  final String profileImage;
  final double rateStar;
  final int amount;
  PurchasedModel({
    required this.imageUrl,
    required this.productName,
    required this.storeName,
    required this.date,
    required this.rateText,
    required this.myId,
    required this.storeId,
    required this.location,
    required this.profileImage,
    required this.rateStar,
    required this.amount,
  });

  PurchasedModel copyWith({
    String? imageUrl,
    String? productName,
    String? storeName,
    String? date,
    String? rateText,
    String? myId,
    String? storeId,
    String? location,
    String? profileImage,
    double? rateStar,
    int? amount,
  }) {
    return PurchasedModel(
      imageUrl: imageUrl ?? this.imageUrl,
      productName: productName ?? this.productName,
      storeName: storeName ?? this.storeName,
      date: date ?? this.date,
      rateText: rateText ?? this.rateText,
      myId: myId ?? this.myId,
      storeId: storeId ?? this.storeId,
      location: location ?? this.location,
      profileImage: profileImage ?? this.profileImage,
      rateStar: rateStar ?? this.rateStar,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'productName': productName,
      'storeName': storeName,
      'date': date,
      'rateText': rateText,
      'myId': myId,
      'storeId': storeId,
      'location': location,
      'profileImage': profileImage,
      'rateStar': rateStar,
      'amount': amount,
    };
  }

  factory PurchasedModel.fromMap(Map<String, dynamic> map) {
    return PurchasedModel(
      imageUrl: map['imageUrl'] as String,
      productName: map['productName'] as String,
      storeName: map['storeName'] as String,
      date: map['date'] as String,
      rateText: map['rateText'] as String,
      myId: map['myId'] as String,
      storeId: map['storeId'] as String,
      location: map['location'] as String,
      profileImage: map['profileImage'] as String,
      rateStar: map['rateStar'] as double,
      amount: map['amount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchasedModel.fromJson(String source) => PurchasedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PurchasedModel(imageUrl: $imageUrl, productName: $productName, storeName: $storeName, date: $date, rateText: $rateText, myId: $myId, storeId: $storeId, location: $location, profileImage: $profileImage, rateStar: $rateStar, amount: $amount)';
  }

  @override
  bool operator ==(covariant PurchasedModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.imageUrl == imageUrl &&
      other.productName == productName &&
      other.storeName == storeName &&
      other.date == date &&
      other.rateText == rateText &&
      other.myId == myId &&
      other.storeId == storeId &&
      other.location == location &&
      other.profileImage == profileImage &&
      other.rateStar == rateStar &&
      other.amount == amount;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
      productName.hashCode ^
      storeName.hashCode ^
      date.hashCode ^
      rateText.hashCode ^
      myId.hashCode ^
      storeId.hashCode ^
      location.hashCode ^
      profileImage.hashCode ^
      rateStar.hashCode ^
      amount.hashCode;
  }
}
