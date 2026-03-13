import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.black,
      ),
      body: const Center(
        child: Text('Profile Screen Content', style: TextStyle(color: AppColors.white)),
      ),
    );
  }
}
