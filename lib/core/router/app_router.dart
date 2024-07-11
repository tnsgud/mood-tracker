import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_tracker/features/authentication/view/sign_up_screen.dart';
import 'package:mood_tracker/feeds/view/feeds_screen.dart';
import 'package:mood_tracker/features/authentication/view/login_screen.dart';
import 'package:mood_tracker/features/main_navigation/view/main_navigation_screen.dart';

final router = GoRouter(
  initialLocation: FirebaseAuth.instance.currentUser == null ? '/login' : '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainNavigationScreen(child: child),
      routes: [
        GoRoute(
          path: '/feeds',
          builder: (context, state) => const FeedsScreen(),
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
