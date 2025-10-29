import 'package:flutter/material.dart';
import 'package:health_profile/ui/widgets/logos/app_logo.dart';

class AuthBasePage extends StatelessWidget {
  const AuthBasePage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80),
          AppLogo(),
          const SizedBox(height: 85),
          child,
        ],
      ),
    );
  }
}
