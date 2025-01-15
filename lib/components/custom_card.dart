// Custom Card Widget with 3D effect
import 'package:flutter/cupertino.dart';

import '../theme/app_colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double height;
  final VoidCallback? onTap;

  const CustomCard({
    Key? key,
    required this.child,
    this.height = 120,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cardBackgroundAccent,
              AppColors.cardBackground,
            ],
          ),
          border: Border.all(
            color: AppColors.cardBorder,
            width: 1,
          ),
          boxShadow: [
            // Outer shadow
            BoxShadow(
              color: AppColors.cardShadowDark,
              offset: const Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
            // Inner glow
            BoxShadow(
              color: AppColors.cardShadowLight,
              offset: const Offset(-2, -2),
              blurRadius: 6,
              spreadRadius: -1,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}