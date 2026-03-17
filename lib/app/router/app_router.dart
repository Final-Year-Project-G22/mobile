import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/pages/register_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // GoRoute(
      //   path: '/',
      //   name: 'home',
      //   builder: (context, state) =>
      //       const Scaffold(body: Center(child: Text('Home'))),
      // ),
      GoRoute(
        path: '/',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
    ],
  );
}
