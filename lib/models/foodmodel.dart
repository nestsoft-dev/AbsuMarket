// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FoodModel {
  final String foodName;
  final String storeName;
  final String storeFCM;
  final String storeOwnerUID;
  final String foodDes;
  final String category;
  final String productUuid;
  final double price;
  final String storePhoneNumber;
  final String foodImage;
  FoodModel({
    required this.foodName,
    required this.storeName,
    required this.storeFCM,
    required this.storeOwnerUID,
    required this.foodDes,
    required this.category,
    required this.productUuid,
    required this.price,
    required this.storePhoneNumber,
    required this.foodImage,
  });

  FoodModel copyWith({
    String? foodName,
    String? storeName,
    String? storeFCM,
    String? storeOwnerUID,
    String? foodDes,
    String? category,
    String? productUuid,
    double? price,
    String? storePhoneNumber,
    String? foodImage,
  }) {
    return FoodModel(
      foodName: foodName ?? this.foodName,
      storeName: storeName ?? this.storeName,
      storeFCM: storeFCM ?? this.storeFCM,
      storeOwnerUID: storeOwnerUID ?? this.storeOwnerUID,
      foodDes: foodDes ?? this.foodDes,
      category: category ?? this.category,
      productUuid: productUuid ?? this.productUuid,
      price: price ?? this.price,
      storePhoneNumber: storePhoneNumber ?? this.storePhoneNumber,
      foodImage: foodImage ?? this.foodImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foodName': foodName,
      'storeName': storeName,
      'storeFCM': storeFCM,
      'storeOwnerUID': storeOwnerUID,
      'foodDes': foodDes,
      'category': category,
      'productUuid': productUuid,
      'price': price,
      'storePhoneNumber': storePhoneNumber,
      'foodImage': foodImage,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      foodName: map['foodName'] as String,
      storeName: map['storeName'] as String,
      storeFCM: map['storeFCM'] as String,
      storeOwnerUID: map['storeOwnerUID'] as String,
      foodDes: map['foodDes'] as String,
      category: map['category'] as String,
      productUuid: map['productUuid'] as String,
      price: map['price'] as double,
      storePhoneNumber: map['storePhoneNumber'] as String,
      foodImage: map['foodImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) => FoodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FoodModel(foodName: $foodName, storeName: $storeName, storeFCM: $storeFCM, storeOwnerUID: $storeOwnerUID, foodDes: $foodDes, category: $category, productUuid: $productUuid, price: $price, storePhoneNumber: $storePhoneNumber, foodImage: $foodImage)';
  }

  @override
  bool operator ==(covariant FoodModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.foodName == foodName &&
      other.storeName == storeName &&
      other.storeFCM == storeFCM &&
      other.storeOwnerUID == storeOwnerUID &&
      other.foodDes == foodDes &&
      other.category == category &&
      other.productUuid == productUuid &&
      other.price == price &&
      other.storePhoneNumber == storePhoneNumber &&
      other.foodImage == foodImage;
  }

  @override
  int get hashCode {
    return foodName.hashCode ^
      storeName.hashCode ^
      storeFCM.hashCode ^
      storeOwnerUID.hashCode ^
      foodDes.hashCode ^
      category.hashCode ^
      productUuid.hashCode ^
      price.hashCode ^
      storePhoneNumber.hashCode ^
      foodImage.hashCode;
  }
}
