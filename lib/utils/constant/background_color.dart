import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'image_strings.dart';
import 'colors.dart';

class BackgroundColor extends StatelessWidget {
  final Widget child;

  const BackgroundColor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Positioned.fill(
          child: Center(
            child: Transform.scale(
              scale: 1.8,
              child: Lottie.asset(
                TImages.lottieAnimation,
                fit: BoxFit.cover,
                repeat: true,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),


        Container(
          color: TColors.primaryBackground.withOpacity(0.5),
          child: child,
        ),
      ],
    );
  }
}
