// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class LodgeModel {
  final String lodgeName;
  final String uploaderUid;
  final String uploadedFCM;
  final double lodgePrice;
    final String category;
  final String productUuid;
  final String lodgeUploadedNumber;
  final String lodgeLocation;
  final String lodgeDescription;
  final List<String> lodgeImages;
  LodgeModel({
    required this.lodgeName,
    required this.uploaderUid,
    required this.uploadedFCM,
    required this.lodgePrice,
    required this.category,
    required this.productUuid,
    required this.lodgeUploadedNumber,
    required this.lodgeLocation,
    required this.lodgeDescription,
    required this.lodgeImages,
  });

  LodgeModel copyWith({
    String? lodgeName,
    String? uploaderUid,
    String? uploadedFCM,
    double? lodgePrice,
    String? category,
    String? productUuid,
    String? lodgeUploadedNumber,
    String? lodgeLocation,
    String? lodgeDescription,
    List<String>? lodgeImages,
  }) {
    return LodgeModel(
      lodgeName: lodgeName ?? this.lodgeName,
      uploaderUid: uploaderUid ?? this.uploaderUid,
      uploadedFCM: uploadedFCM ?? this.uploadedFCM,
      lodgePrice: lodgePrice ?? this.lodgePrice,
      category: category ?? this.category,
      productUuid: productUuid ?? this.productUuid,
      lodgeUploadedNumber: lodgeUploadedNumber ?? this.lodgeUploadedNumber,
      lodgeLocation: lodgeLocation ?? this.lodgeLocation,
      lodgeDescription: lodgeDescription ?? this.lodgeDescription,
      lodgeImages: lodgeImages ?? this.lodgeImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lodgeName': lodgeName,
      'uploaderUid': uploaderUid,
      'uploadedFCM': uploadedFCM,
      'lodgePrice': lodgePrice,
      'category': category,
      'productUuid': productUuid,
      'lodgeUploadedNumber': lodgeUploadedNumber,
      'lodgeLocation': lodgeLocation,
      'lodgeDescription': lodgeDescription,
      'lodgeImages': lodgeImages,
    };
  }

  factory LodgeModel.fromMap(Map<String, dynamic> map) {
    return LodgeModel(
      lodgeName: map['lodgeName'] as String,
      uploaderUid: map['uploaderUid'] as String,
      uploadedFCM: map['uploadedFCM'] as String,
      lodgePrice: map['lodgePrice'] as double,
      category: map['category'] as String,
      productUuid: map['productUuid'] as String,
      lodgeUploadedNumber: map['lodgeUploadedNumber'] as String,
      lodgeLocation: map['lodgeLocation'] as String,
      lodgeDescription: map['lodgeDescription'] as String,
      lodgeImages: List<String>.from((map['lodgeImages'] as List<String>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory LodgeModel.fromJson(String source) => LodgeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LodgeModel(lodgeName: $lodgeName, uploaderUid: $uploaderUid, uploadedFCM: $uploadedFCM, lodgePrice: $lodgePrice, category: $category, productUuid: $productUuid, lodgeUploadedNumber: $lodgeUploadedNumber, lodgeLocation: $lodgeLocation, lodgeDescription: $lodgeDescription, lodgeImages: $lodgeImages)';
  }

  @override
  bool operator ==(covariant LodgeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.lodgeName == lodgeName &&
      other.uploaderUid == uploaderUid &&
      other.uploadedFCM == uploadedFCM &&
      other.lodgePrice == lodgePrice &&
      other.category == category &&
      other.productUuid == productUuid &&
      other.lodgeUploadedNumber == lodgeUploadedNumber &&
      other.lodgeLocation == lodgeLocation &&
      other.lodgeDescription == lodgeDescription &&
      listEquals(other.lodgeImages, lodgeImages);
  }

  @override
  int get hashCode {
    return lodgeName.hashCode ^
      uploaderUid.hashCode ^
      uploadedFCM.hashCode ^
      lodgePrice.hashCode ^
      category.hashCode ^
      productUuid.hashCode ^
      lodgeUploadedNumber.hashCode ^
      lodgeLocation.hashCode ^
      lodgeDescription.hashCode ^
      lodgeImages.hashCode;
  }
}
