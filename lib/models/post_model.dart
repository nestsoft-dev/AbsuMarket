// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostModel {
  final String imageUrl;
  final String storeId;
  DateTime createdAt;
  DateTime expirationTime;
  PostModel({
    required this.imageUrl,
    required this.storeId,
    required this.createdAt,
    required this.expirationTime,
  });

  PostModel copyWith({
    String? imageUrl,
    String? storeId,
    DateTime? createdAt,
    DateTime? expirationTime,
  }) {
    return PostModel(
      imageUrl: imageUrl ?? this.imageUrl,
      storeId: storeId ?? this.storeId,
      createdAt: createdAt ?? this.createdAt,
      expirationTime: expirationTime ?? this.expirationTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'storeId': storeId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'expirationTime': expirationTime.millisecondsSinceEpoch,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      imageUrl: map['imageUrl'] as String,
      storeId: map['storeId'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      expirationTime: DateTime.fromMillisecondsSinceEpoch(map['expirationTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(imageUrl: $imageUrl, storeId: $storeId, createdAt: $createdAt, expirationTime: $expirationTime)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.imageUrl == imageUrl &&
      other.storeId == storeId &&
      other.createdAt == createdAt &&
      other.expirationTime == expirationTime;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
      storeId.hashCode ^
      createdAt.hashCode ^
      expirationTime.hashCode;
  }
}
