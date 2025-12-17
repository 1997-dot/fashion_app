import 'package:flutter/material.dart';
import 'package:fashion_app/core/configs/theme/app_colors.dart';

/// Reusable password field widget for auth forms
/// Includes show/hide password toggle
class AuthPasswordField extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final String? errorText;
  final bool enabled;
  final void Function(String)? onChanged;

  const AuthPasswordField({
    super.key,
    required this.hint,
    this.controller,
    this.errorText,
    this.enabled = true,
    this.onChanged,
  });

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(8),
            border: widget.errorText != null
                ? Border.all(color: AppColors.error, width: 1)
                : null,
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: _obscureText,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.errorText!,
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
