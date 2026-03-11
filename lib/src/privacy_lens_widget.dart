import 'dart:ui';
import 'package:flutter/material.dart';

/// A widget that masks its [child] with a blur effect for privacy.
class PrivacyLens extends StatelessWidget {
  final Widget child;
  final double blurStrength;
  final bool isProtected;

  const PrivacyLens({
    super.key,
    required this.child,
    this.blurStrength = 10.0,
    this.isProtected = true,
  });

  @override
  Widget build(BuildContext context) {
    // If not protected, return child directly to avoid unnecessary tree depth
    if (!isProtected) return child;

    return Stack(
      children: [
        child,
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurStrength,
              sigmaY: blurStrength,
            ),
            child: Container(
              color: Colors.transparent, // Background transparent for better performance
            ),
          ),
        ),
      ],
    );
  }
}