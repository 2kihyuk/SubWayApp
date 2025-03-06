import 'package:flutter/material.dart';
import 'package:privateapp/Screen/Default_layout/default_layout.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: Text('Profile Page - Main'),
      ),
    );
  }
}
