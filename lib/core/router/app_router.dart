import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_tracker/features/authentication/view/sign_up_screen.dart';
import 'package:mood_tracker/features/feeds/view/feeds_screen.dart';
import 'package:mood_tracker/features/authentication/view/login_screen.dart';
import 'package:mood_tracker/features/main_navigation/view/main_navigation_screen.dart';
import 'package:mood_tracker/features/posting/view/posting_screen.dart';

final router = GoRouter(
  initialLocation:
      FirebaseAuth.instance.currentUser == null ? '/login' : '/feeds',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainNavigationScreen(
        currentPath: state.fullPath ?? 'non-path',
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/feeds',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const FeedsScreen(),
              transitionDuration: const Duration(milliseconds: 150),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity:
                      CurveTween(curve: Curves.easeInOut).animate(animation),
                  child: child,
                );
              },
            );
          },
          // builder: (context, state) => const FeedsScreen(),
        ),
        GoRoute(
          path: '/posting',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const PostingScreen(),
              transitionDuration: const Duration(milliseconds: 150),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity:
                      CurveTween(curve: Curves.easeInOut).animate(animation),
                  child: child,
                );
              },
            );
          },
        )
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const SignUpScreen(),
    ),
  ],
);
