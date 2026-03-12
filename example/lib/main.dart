import 'package:flutter/material.dart';
import 'package:privacy_lens/privacy_lens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatefulWidget {
  const ExampleHome({super.key});

  @override
  State<ExampleHome> createState() => _ExampleHomeState();
}

class _ExampleHomeState extends State<ExampleHome> {
  bool _isManualProtected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Lens Example"),
        actions: [
          // একটি সুইচ রাখা যাতে ইউজার টেস্ট করতে পারে
          Switch(
            value: _isManualProtected,
            onChanged: (val) => setState(() => _isManualProtected = val),
          )
        ],
      ),
      body: PrivacyLens(
        isProtected: _isManualProtected,
        blurStrength: 10.0,
        overlayColor: Colors.blueGrey,
        animationDuration: const Duration(milliseconds: 500),
        privacyChild: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.security, color: Colors.white, size: 60),
            SizedBox(height: 10),
            Text(
              "App is Protected",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        child: const UserProfileScreen(),
      ),
    );
  }
}

// এটি ডামি কন্টেন্ট জাস্ট দেখানোর জন্য
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 20),
          const Text("Faysal Ahammed", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("Flutter Developer"),
          const Divider(height: 40),
          const ListTile(
            leading: Icon(Icons.email),
            title: Text("Sensitive Email"),
            subtitle: Text("faysal@example.com"),
          ),
          const ListTile(
            leading: Icon(Icons.phone),
            title: Text("Private Phone"),
            subtitle: Text("+880 1234 567890"),
          ),
          const Spacer(),
          const Text("Try minimizing the app to see auto-blur!"),
        ],
      ),
    );
  }
}