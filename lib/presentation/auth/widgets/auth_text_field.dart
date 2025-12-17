import 'package:flutter/material.dart';
import 'package:fashion_app/core/configs/theme/app_colors.dart';

/// Reusable text field widget for auth forms
/// Styled to match the app's dark theme
class AuthTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? errorText;
  final bool enabled;
  final void Function(String)? onChanged;

  const AuthTextField({
    super.key,
    required this.hint,
    this.controller,
    this.keyboardType,
    this.errorText,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF404040),
            borderRadius: BorderRadius.circular(8),
            border: errorText != null
                ? Border.all(color: AppColors.error, width: 1)
                : null,
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            enabled: enabled,
            onChanged: onChanged,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              errorText!,
              style: TextStyle(
                color: AppColors.error,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
