import 'dart:ui';
import 'package:flutter/foundation.dart'; // kReleaseMode 
import 'package:flutter/material.dart';


/// A widget that protects sensitive content by applying a blur filter.
/// [PrivacyLens] can automatically blur content when the app lifecycle 
/// changes to inactive/paused, or it can be manually triggered via [isProtected].

class PrivacyLens extends StatefulWidget {
  /// The widget to be protected.
  final Widget child;

  /// If set to true, the [child] will always be masked with a blur effect.
  final bool isProtected;

  /// The intensity of the blur effect. Defaults to 10.0.
  final double blurStrength;

  /// The color of the overlay applied on top of the blur.
  final Color overlayColor;

  /// An optional widget to display in the center when the content is blurred.
  final Widget? privacyChild; 

  /// Whether the protection should be active during debug mode. Defaults to true for development convenience.
  final bool enableInDebug; 
  
  /// The duration of the blur animation transition. Defaults to 300 milliseconds.
  final Duration animationDuration; 

/// Creates a [PrivacyLens] widget.
  const PrivacyLens({
    super.key,
    required this.child,
    this.isProtected = false,
    this.blurStrength = 10.0,
    this.overlayColor = Colors.black,
    this.privacyChild,
    this.enableInDebug = true,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<PrivacyLens> createState() => _PrivacyLensState();
}

class _PrivacyLensState extends State<PrivacyLens> with WidgetsBindingObserver {
  bool _isBackgrounded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(PrivacyLens oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isProtected != widget.isProtected) {
      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _isBackgrounded = (state == AppLifecycleState.inactive || state == AppLifecycleState.paused);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debug mode check for development convenience, can be disabled via enableInDebug
    if (!kReleaseMode && !widget.enableInDebug) {
      return widget.child;
    }

    final bool shouldBlur = widget.isProtected || _isBackgrounded;

    return Stack(
      children: [
        widget.child,
        // 3. animated blur effect with customizable duration
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: shouldBlur ? widget.blurStrength : 0),
          duration: widget.animationDuration,
          builder: (context, blurValue, child) {
            if (blurValue <= 0) return const SizedBox.shrink();
            
            return Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
                child: Container(
                  color: widget.overlayColor.withValues(alpha: 0.01),
                  child: Center(
                    // 2 custom child with fade-in effect when blur is active
                    child: AnimatedOpacity(
                      opacity: blurValue >= widget.blurStrength ? 1.0 : 0.0,
                      duration: widget.animationDuration,
                      child: widget.privacyChild ?? const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}