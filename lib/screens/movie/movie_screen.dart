import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text('Movies', style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.black,
      ),
      body: const Center(
        child: Text('Movie Screen Content', style: TextStyle(color: AppColors.white)),
      ),
    );
  }
}
