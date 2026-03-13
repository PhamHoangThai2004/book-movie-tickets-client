import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text('home'.tr(), style: const TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.black,
      ),
      body: Center(
        child: Text('home'.tr(), style: const TextStyle(color: AppColors.white)),
      ),
    );
  }
}
