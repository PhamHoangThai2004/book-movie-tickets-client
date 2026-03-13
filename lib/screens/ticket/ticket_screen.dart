import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text('My Tickets', style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.black,
      ),
      body: const Center(
        child: Text('Ticket Screen Content', style: TextStyle(color: AppColors.white)),
      ),
    );
  }
}
