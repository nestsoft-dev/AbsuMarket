// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RatingModel {
  final String name;
  final double stars;
  final String comments;
  final String image;
  RatingModel({
    required this.name,
    required this.stars,
    required this.comments,
    required this.image,
  });
  //timestamp

  RatingModel copyWith({
    String? name,
    double? stars,
    String? comments,
    String? image,
  }) {
    return RatingModel(
      name: name ?? this.name,
      stars: stars ?? this.stars,
      comments: comments ?? this.comments,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'stars': stars,
      'comments': comments,
      'image': image,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      name: map['name'] as String,
      stars: map['stars'] as double,
      comments: map['comments'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingModel.fromJson(String source) => RatingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RatingModel(name: $name, stars: $stars, comments: $comments, image: $image)';
  }

  @override
  bool operator ==(covariant RatingModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.stars == stars &&
      other.comments == comments &&
      other.image == image;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      stars.hashCode ^
      comments.hashCode ^
      image.hashCode;
  }
}
