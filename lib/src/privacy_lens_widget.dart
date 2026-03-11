import 'dart:ui';
import 'package:flutter/material.dart';

class PrivacyLens extends StatefulWidget {
  final Widget child;
  final bool isProtected; 
  final double blurStrength;

  const PrivacyLens({
    super.key,
    required this.child,
    this.isProtected = false,
    this.blurStrength = 10.0,
  });

  @override
  State<PrivacyLens> createState() => _PrivacyLensState();
}

class _PrivacyLensState extends State<PrivacyLens> with WidgetsBindingObserver {
  bool _isBackgrounded = false; // App lifecycle state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
      
  }

  @override
  void didUpdateWidget(PrivacyLens oldWidget) {
    super.didUpdateWidget(oldWidget);
    // যদি isProtected এর মান চেঞ্জ হয়, তবে UI রিফ্রেশ করবে
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
    // Logic: 
    // 1. widget.isProtected = true (All time blur)
    // 2. _isBackgrounded = true (App background = blur)
    final bool shouldBlur = widget.isProtected || _isBackgrounded ;

    return Stack(
      children: [
        widget.child,
        if (shouldBlur)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: widget.blurStrength, sigmaY: widget.blurStrength),
              child: Container(color: Colors.black.withValues(alpha: 0.01),),
            ),
          ),
      ],
    );
  }
}