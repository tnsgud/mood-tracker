import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mood_tracker/features/authentication/view_model/auth_view_model.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
              ),
              const Gap(30),
              TextField(
                controller: _passwordController,
              ),
              const Gap(20),
              GestureDetector(
                onTap: () => ref.watch(authProvider.notifier).signUp(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context,
                    ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: const Text('sign up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
