import 'package:flutter/material.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  const NavScreen({super.key});

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 1),
      pageBuilder: (_, __, ___) => const NavScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Nav Screen'),
    );
  }
}
