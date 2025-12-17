import 'package:fashion_app/data/auth/models/user_model.dart';

/// Authentication Response Model
/// Represents the response from sign in and sign up API calls
class AuthResponseModel {
  /// Authentication token (JWT)
  final String token;

  /// Authenticated user data
  final UserModel user;

  const AuthResponseModel({
    required this.token,
    required this.user,
  });

  /// Create AuthResponseModel from JSON
  /// Used when receiving response from API
  ///
  /// Expected JSON structure:
  /// ```json
  /// {
  ///   "token": "eyJ0eXAiOiJKV1...",
  ///   "user": {
  ///     "id": 1,
  ///     "name": "John Doe",
  ///     "email": "john@example.com",
  ///     ...
  ///   }
  /// }
  /// ```
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  /// Convert AuthResponseModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }
}
