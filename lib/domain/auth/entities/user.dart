import 'package:equatable/equatable.dart';

/// User entity - Domain layer representation of a user
/// This is the core business object used throughout the app
/// Independent of data sources and frameworks
class User extends Equatable {
  /// User's unique identifier
  final int id;

  /// User's full name
  final String name;

  /// User's email address
  final String email;

  /// User's phone number (optional)
  final String? phone;

  /// URL to user's profile image (optional)
  final String? image;

  /// When the user account was created
  final DateTime? createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.image,
    this.createdAt,
  });

  /// Create empty user (for initial state)
  const User.empty()
      : id = 0,
        name = '',
        email = '',
        phone = null,
        image = null,
        createdAt = null;

  /// Check if user is empty
  bool get isEmpty => id == 0 && name.isEmpty && email.isEmpty;

  /// Check if user is not empty
  bool get isNotEmpty => !isEmpty;

  /// Get user initials from name (for avatar)
  String get initials {
    if (name.isEmpty) return '';
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  /// Get display name (name or email if name is empty)
  String get displayName {
    if (name.isNotEmpty) return name;
    if (email.isNotEmpty) return email.split('@')[0];
    return 'User';
  }

  @override
  List<Object?> get props => [id, name, email, phone, image, createdAt];

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phone: $phone, image: $image, createdAt: $createdAt)';
  }
}
