import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'image_strings.dart';
import 'colors.dart'; // Assuming your colors are in this file

class BackgroundColor extends StatelessWidget {
  final Widget child;

  const BackgroundColor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Lottie animation in the background
        Positioned.fill(
          child: Lottie.asset(
            TImages.lottieAnimation,
            fit: BoxFit.cover,
            repeat: true,
          ),
        ),

        Container(
          color: TColors.primaryBackground.withOpacity(0.5), // Use TColors here
          child: child,
        ),
      ],
    );
  }
}
