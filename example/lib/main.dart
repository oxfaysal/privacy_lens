import 'package:flutter/material.dart';
import 'package:privacy_lens/privacy_lens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Privacy Lens Example")),
        body: Center(
          child: PrivacyLens(
            isProtected: true,
            blurStrength: 10.0,
            child: const Text(
              "Sensitive Data: 1234-5678-9012",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}