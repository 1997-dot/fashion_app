import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/core/configs/theme/app_colors.dart';
import 'package:fashion_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:fashion_app/presentation/auth/bloc/auth_event.dart';
import 'package:fashion_app/presentation/auth/bloc/auth_state.dart';
import 'package:fashion_app/presentation/auth/widgets/auth_button.dart';
import 'package:fashion_app/presentation/auth/widgets/auth_password_field.dart';
import 'package:fashion_app/presentation/auth/widgets/auth_text_field.dart';
import 'package:fashion_app/presentation/home/pages/home.dart';
import 'package:fashion_app/service_locator.dart';

/// Sign Up Page
/// Allows users to create a new account
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _generalError;
  String? _termsError;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    // Clear previous errors
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
      _generalError = null;
      _termsError = null;
    });

    // Get values
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Basic validation
    bool hasError = false;

    if (name.isEmpty) {
      setState(() {
        _nameError = 'Name is required';
      });
      hasError = true;
    }

    if (email.isEmpty) {
      setState(() {
        _emailError = 'Email is required';
      });
      hasError = true;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
      hasError = true;
    }

    if (!_agreeToTerms) {
      setState(() {
        _termsError = 'Please agree to terms and conditions';
      });
      hasError = true;
    }

    if (hasError) return;

    // Dispatch sign up event
    context.read<AuthBloc>().add(
          SignUpEvent(
            name: name,
            email: email,
            password: password,
          ),
        );
  }

  void _navigateToSignIn() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigate to home page on successful sign up
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (state is AuthError) {
            // Set field errors if available
            if (state.hasFieldErrors) {
              setState(() {
                _nameError = state.getFieldError('name');
                _emailError = state.getFieldError('email');
                _passwordError = state.getFieldError('password');
              });
            } else {
              // Show general error under password field if no field-specific errors
              setState(() {
                _generalError = state.message.contains('email') &&
                        (state.message.contains('taken') ||
                            state.message.contains('exists') ||
                            state.message.contains('already'))
                    ? 'This email is already registered. Please use a different email or try signing in.'
                    : state.message.contains('password') &&
                            (state.message.contains('weak') ||
                                state.message.contains('short') ||
                                state.message.contains('requirements'))
                        ? 'Password must be at least 8 characters long and contain letters and numbers.'
                        : state.message;
              });
            }
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),

                  // Title - Centered
                  Text(
                    'CREATE ACCOUNT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle - Centered
                  Text(
                    'Sign up to get started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Name field
                  AuthTextField(
                    hint: 'Name',
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    errorText: _nameError,
                    enabled: !isLoading,
                    onChanged: (_) {
                      if (_nameError != null) {
                        setState(() {
                          _nameError = null;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // Email field
                  AuthTextField(
                    hint: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    errorText: _emailError,
                    enabled: !isLoading,
                    onChanged: (_) {
                      if (_emailError != null) {
                        setState(() {
                          _emailError = null;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // Password field
                  AuthPasswordField(
                    hint: 'Password',
                    controller: _passwordController,
                    errorText: _passwordError,
                    enabled: !isLoading,
                    onChanged: (_) {
                      if (_passwordError != null) {
                        setState(() {
                          _passwordError = null;
                        });
                      }
                    },
                  ),

                  // General error message under password field
                  if (_generalError != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.error.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: AppColors.error,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _generalError!,
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),

                  // Terms and conditions checkbox
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _agreeToTerms,
                          onChanged: isLoading
                              ? null
                              : (value) {
                                  setState(() {
                                    _agreeToTerms = value ?? false;
                                    if (_agreeToTerms) {
                                      _termsError = null;
                                    }
                                  });
                                },
                          activeColor: AppColors.textPrimary,
                          checkColor: AppColors.background,
                          side: BorderSide(
                            color: _termsError != null
                                ? AppColors.error
                                : AppColors.textSecondary,
                            width: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'I agree to terms and conditions',
                          style: TextStyle(
                            color: _termsError != null
                                ? AppColors.error
                                : AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Terms error message
                  if (_termsError != null) ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        _termsError!,
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 32),

                  // Sign Up button
                  AuthButton(
                    text: 'SIGN UP',
                    onPressed: _onSignUp,
                    isLoading: isLoading,
                  ),

                  const SizedBox(height: 24),

                  // Log in link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: isLoading ? null : _navigateToSignIn,
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
