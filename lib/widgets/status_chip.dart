import 'package:flutter/material.dart';
import '../utils/constants.dart';

class StatusChip extends StatelessWidget {
  final String status; 
  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.statusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12) , 
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        status[0]+status.substring(1).toLowerCase() , // 'APPLIED' -> 'Applied'
        style: TextStyle(fontSize: 10 , fontWeight: FontWeight.w500 , color: color),
      ),
    );
  }
}
