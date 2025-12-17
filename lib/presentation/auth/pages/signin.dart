import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/core/configs/theme/app_colors.dart';
import 'package:fashion_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:fashion_app/presentation/auth/bloc/auth_event.dart';
import 'package:fashion_app/presentation/auth/bloc/auth_state.dart';
import 'package:fashion_app/presentation/auth/pages/signup.dart';
import 'package:fashion_app/presentation/auth/widgets/auth_button.dart';
import 'package:fashion_app/presentation/auth/widgets/auth_password_field.dart';
import 'package:fashion_app/presentation/auth/widgets/auth_text_field.dart';
import 'package:fashion_app/presentation/home/pages/home.dart';
import 'package:fashion_app/service_locator.dart';

/// Sign In Page
/// Allows users to sign in with email and password
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _generalError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    // Clear previous errors
    setState(() {
      _emailError = null;
      _passwordError = null;
      _generalError = null;
    });

    // Get values
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Basic validation
    bool hasError = false;

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

    if (hasError) return;

    // Dispatch sign in event
    context.read<AuthBloc>().add(
          SignInEvent(
            email: email,
            password: password,
          ),
        );
  }

  void _navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigate to home page on successful sign in
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (state is AuthError) {
            // Set field errors if available
            if (state.hasFieldErrors) {
              setState(() {
                _emailError = state.getFieldError('email');
                _passwordError = state.getFieldError('password');
              });
            } else {
              // Show general error under password field if no field-specific errors
              setState(() {
                _generalError = state.message.contains('credentials') ||
                        state.message.contains('Invalid') ||
                        state.message.contains('incorrect') ||
                        state.message.contains('not found')
                    ? 'Invalid email or password. Please check your credentials and try again.'
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
                    'SIGN IN',
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
                    'Welcome back! Please sign in to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 48),

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

                  const SizedBox(height: 32),

                  // Sign In button
                  AuthButton(
                    text: 'SIGN IN',
                    onPressed: _onSignIn,
                    isLoading: isLoading,
                  ),

                  const SizedBox(height: 24),

                  // Sign Up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: isLoading ? null : _navigateToSignUp,
                        child: Text(
                          'Sign up',
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
