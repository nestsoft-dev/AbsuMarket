// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PendingModel {
  final String imageUrl;
  final String productname;
  final String productDes;
  final String storename;
  final String sellerFCM;
  final String buyFCM;
  final String sellerId;
  final String buerId;
  final String location;
  final String phoneNumber;
  final String prodctID;
  final double price;
  PendingModel({
    required this.imageUrl,
    required this.productname,
    required this.productDes,
    required this.storename,
    required this.sellerFCM,
    required this.buyFCM,
    required this.sellerId,
    required this.buerId,
    required this.location,
    required this.phoneNumber,
    required this.prodctID,
    required this.price,
  });

  PendingModel copyWith({
    String? imageUrl,
    String? productname,
    String? productDes,
    String? storename,
    String? sellerFCM,
    String? buyFCM,
    String? sellerId,
    String? buerId,
    String? location,
    String? phoneNumber,
    String? prodctID,
    double? price,
  }) {
    return PendingModel(
      imageUrl: imageUrl ?? this.imageUrl,
      productname: productname ?? this.productname,
      productDes: productDes ?? this.productDes,
      storename: storename ?? this.storename,
      sellerFCM: sellerFCM ?? this.sellerFCM,
      buyFCM: buyFCM ?? this.buyFCM,
      sellerId: sellerId ?? this.sellerId,
      buerId: buerId ?? this.buerId,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      prodctID: prodctID ?? this.prodctID,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'productname': productname,
      'productDes': productDes,
      'storename': storename,
      'sellerFCM': sellerFCM,
      'buyFCM': buyFCM,
      'sellerId': sellerId,
      'buerId': buerId,
      'location': location,
      'phoneNumber': phoneNumber,
      'prodctID': prodctID,
      'price': price,
    };
  }

  factory PendingModel.fromMap(Map<String, dynamic> map) {
    return PendingModel(
      imageUrl: map['imageUrl'] as String,
      productname: map['productname'] as String,
      productDes: map['productDes'] as String,
      storename: map['storename'] as String,
      sellerFCM: map['sellerFCM'] as String,
      buyFCM: map['buyFCM'] as String,
      sellerId: map['sellerId'] as String,
      buerId: map['buerId'] as String,
      location: map['location'] as String,
      phoneNumber: map['phoneNumber'] as String,
      prodctID: map['prodctID'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PendingModel.fromJson(String source) => PendingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PendingModel(imageUrl: $imageUrl, productname: $productname, productDes: $productDes, storename: $storename, sellerFCM: $sellerFCM, buyFCM: $buyFCM, sellerId: $sellerId, buerId: $buerId, location: $location, phoneNumber: $phoneNumber, prodctID: $prodctID, price: $price)';
  }

  @override
  bool operator ==(covariant PendingModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.imageUrl == imageUrl &&
      other.productname == productname &&
      other.productDes == productDes &&
      other.storename == storename &&
      other.sellerFCM == sellerFCM &&
      other.buyFCM == buyFCM &&
      other.sellerId == sellerId &&
      other.buerId == buerId &&
      other.location == location &&
      other.phoneNumber == phoneNumber &&
      other.prodctID == prodctID &&
      other.price == price;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
      productname.hashCode ^
      productDes.hashCode ^
      storename.hashCode ^
      sellerFCM.hashCode ^
      buyFCM.hashCode ^
      sellerId.hashCode ^
      buerId.hashCode ^
      location.hashCode ^
      phoneNumber.hashCode ^
      prodctID.hashCode ^
      price.hashCode;
  }
}
