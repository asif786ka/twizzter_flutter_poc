import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  static const String routeName = '/notifications';

  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Notifications'),
      ),
    );
  }
}
