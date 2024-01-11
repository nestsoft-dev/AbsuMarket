// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'rating_model.dart';

class ProductModel {
  final String productName;
  final String storeName;
  final String storeFCM;
  final String storeOwnerUID;
  final String productDes;
  final String category;
  final String productId;
  final String productCounpon;
  final String location;
  final double price;
  final double quantity;
  final List<RatingModel> rate;
  final double discountprice;
  final List<dynamic> images;
  final List<dynamic> sizes;
  ProductModel({
    required this.productName,
    required this.storeName,
    required this.storeFCM,
    required this.storeOwnerUID,
    required this.productDes,
    required this.category,
    required this.productId,
    required this.productCounpon,
    required this.location,
    required this.price,
    required this.quantity,
    required this.rate,
    required this.discountprice,
    required this.images,
    required this.sizes,
  });

  ProductModel copyWith({
    String? productName,
    String? storeName,
    String? storeFCM,
    String? storeOwnerUID,
    String? productDes,
    String? category,
    String? productId,
    String? productCounpon,
    String? location,
    double? price,
    double? quantity,
    List<RatingModel>? rate,
    double? discountprice,
    List<dynamic>? images,
    List<dynamic>? sizes,
  }) {
    return ProductModel(
      productName: productName ?? this.productName,
      storeName: storeName ?? this.storeName,
      storeFCM: storeFCM ?? this.storeFCM,
      storeOwnerUID: storeOwnerUID ?? this.storeOwnerUID,
      productDes: productDes ?? this.productDes,
      category: category ?? this.category,
      productId: productId ?? this.productId,
      productCounpon: productCounpon ?? this.productCounpon,
      location: location ?? this.location,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      rate: rate ?? this.rate,
      discountprice: discountprice ?? this.discountprice,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'storeName': storeName,
      'storeFCM': storeFCM,
      'storeOwnerUID': storeOwnerUID,
      'productDes': productDes,
      'category': category,
      'productId': productId,
      'productCounpon': productCounpon,
      'location': location,
      'price': price,
      'quantity': quantity,
      'rate': rate.map((x) => x.toMap()).toList(),
      'discountprice': discountprice,
      'images': images,
      'sizes': sizes,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productName: map['productName'] as String,
      storeName: map['storeName'] as String,
      storeFCM: map['storeFCM'] as String,
      storeOwnerUID: map['storeOwnerUID'] as String,
      productDes: map['productDes'] as String,
      category: map['category'] as String,
      productId: map['productId'] as String,
      productCounpon: map['productCounpon'] as String,
      location: map['location'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as double,
      rate: List<RatingModel>.from(
        (map['rate'] as List<dynamic>).map<RatingModel>(
          (x) => RatingModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      discountprice: map['discountprice'] as double,
      images: List<dynamic>.from((map['images'] as List<dynamic>)),
      sizes: List<dynamic>.from((map['sizes'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(productName: $productName, storeName: $storeName, storeFCM: $storeFCM, storeOwnerUID: $storeOwnerUID, productDes: $productDes, category: $category, productId: $productId, productCounpon: $productCounpon, location: $location, price: $price, quantity: $quantity, rate: $rate, discountprice: $discountprice, images: $images, sizes: $sizes)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.productName == productName &&
        other.storeName == storeName &&
        other.storeFCM == storeFCM &&
        other.storeOwnerUID == storeOwnerUID &&
        other.productDes == productDes &&
        other.category == category &&
        other.productId == productId &&
        other.productCounpon == productCounpon &&
        other.location == location &&
        other.price == price &&
        other.quantity == quantity &&
        listEquals(other.rate, rate) &&
        other.discountprice == discountprice &&
        listEquals(other.images, images) &&
        listEquals(other.sizes, sizes);
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        storeName.hashCode ^
        storeFCM.hashCode ^
        storeOwnerUID.hashCode ^
        productDes.hashCode ^
        category.hashCode ^
        productId.hashCode ^
        productCounpon.hashCode ^
        location.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        rate.hashCode ^
        discountprice.hashCode ^
        images.hashCode ^
        sizes.hashCode;
  }
}

 // final String storePhoneNumber;