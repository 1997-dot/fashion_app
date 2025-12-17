import 'package:fashion_app/domain/auth/entities/user.dart';

/// User Model - Data layer representation
/// Extends User entity and adds JSON serialization
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.image,
    super.createdAt,
  });

  /// Create UserModel from JSON
  /// Used when receiving data from API
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  /// Convert UserModel to JSON
  /// Used when sending data to API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      if (phone != null) 'phone': phone,
      if (image != null) 'image': image,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  /// Create UserModel from User entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      image: user.image,
      createdAt: user.createdAt,
    );
  }

  /// Create copy with updated fields
  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
