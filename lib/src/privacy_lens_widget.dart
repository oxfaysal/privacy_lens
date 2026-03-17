import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines the visual style of the privacy protection layer.
enum PrivacyBlurType { 
  /// Standard Gaussian blur effect.
  gaussian, 
  
  /// Pixelated mosaic effect for a retro or censored look.
  pixelate, 
  
  /// A frosted glass effect with higher opacity for a premium UI feel.
  frosted 
}

/// A controller used to programmatically trigger privacy protection across 
/// multiple [PrivacyLens] widgets simultaneously (Scoped Protection).
class PrivacyLensController extends ChangeNotifier {
  bool _isGlobalProtected = false;

  /// Returns whether the global protection is currently active.
  bool get isGlobalProtected => _isGlobalProtected;

  /// Activates the protection layer.
  void show() {
    if (!_isGlobalProtected) {
      _isGlobalProtected = true;
      notifyListeners();
    }
  }

  /// Deactivates the protection layer.
  void hide() {
    if (_isGlobalProtected) {
      _isGlobalProtected = false;
      notifyListeners();
    }
  }

  /// Toggles the protection layer state.
  void toggle() {
    _isGlobalProtected = !_isGlobalProtected;
    notifyListeners();
  }
}

/// A widget that protects sensitive UI content by applying customizable filters.
/// 
/// It automatically blurs when the app is backgrounded or when manually 
/// triggered via [isProtected] or a [PrivacyLensController].
class PrivacyLens extends StatefulWidget {
  /// The widget tree to be protected.
  final Widget child;

  /// Manually force the protection layer to be active.
  final bool isProtected;

  /// The intensity of the blur/filter effect. Defaults to 10.0.
  final double blurStrength;

  /// The color of the overlay applied over the filter.
  final Color overlayColor;

  /// A widget (e.g., an icon or logo) to display when protection is active.
  final Widget? privacyChild;

  /// If false, protection is disabled during development (debug mode).
  final bool enableInDebug;

  /// The speed of the transition animation.
  final Duration animationDuration;

  /// The visual style of the protection (e.g., gaussian, pixelate, frosted).
  final PrivacyBlurType blurType;

  /// An optional controller to manage protection state externally.
  final PrivacyLensController? controller;

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
    this.blurType = PrivacyBlurType.gaussian,
    this.controller,
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
    widget.controller?.addListener(_handleControllerUpdate);
  }

  void _handleControllerUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(PrivacyLens oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleControllerUpdate);
      widget.controller?.addListener(_handleControllerUpdate);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (mounted) {
      setState(() {
        _isBackgrounded = (state == AppLifecycleState.inactive || state == AppLifecycleState.paused);
      });
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerUpdate);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if protection should be skipped in debug mode
    if (!kReleaseMode && !widget.enableInDebug) {
      return widget.child;
    }

    final bool isControllerProtected = widget.controller?.isGlobalProtected ?? false;
    final bool shouldBlur = widget.isProtected || _isBackgrounded || isControllerProtected;

    return Stack(
      children: [
        widget.child,
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: shouldBlur ? widget.blurStrength : 0),
          duration: widget.animationDuration,
          builder: (context, blurValue, child) {
            if (blurValue <= 0) return const SizedBox.shrink();

            return Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: _getFilter(blurValue),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.blurType == PrivacyBlurType.frosted
                          ? widget.overlayColor.withValues(alpha: 0.2)
                          : widget.overlayColor.withValues(alpha: 0.01),
                    ),
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: blurValue >= (widget.blurStrength * 0.8) ? 1.0 : 0.0,
                        duration: widget.animationDuration,
                        child: widget.privacyChild ?? const SizedBox.shrink(),
                      ),
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

  /// Generates the appropriate filter based on the selected [PrivacyBlurType].
  ImageFilter _getFilter(double value) {
    switch (widget.blurType) {
      case PrivacyBlurType.pixelate:
        // Current matrix implementation for basic pixelation simulation
        return ImageFilter.matrix(
          Matrix4.diagonal3Values(1 / (value + 1), 1 / (value + 1), 1).storage,
          filterQuality: FilterQuality.none,
        );
      case PrivacyBlurType.frosted:
      case PrivacyBlurType.gaussian:
      default:
        return ImageFilter.blur(sigmaX: value, sigmaY: value);
    }
  }
}