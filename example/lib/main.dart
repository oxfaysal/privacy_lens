import 'package:flutter/material.dart';
import 'package:privacy_lens/privacy_lens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
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
  // 1. Controller instance
  final PrivacyLensController _privacyController = PrivacyLensController();
  
  // Configuration variables
  PrivacyBlurType _selectedBlurType = PrivacyBlurType.gaussian;
  bool _isManualProtected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Lens Pro"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {
              _isManualProtected = false;
              _privacyController.hide();
            }),
          )
        ],
      ),
      body: PrivacyLens(
        // 2. New features added to the widget
        controller: _privacyController, 
        isProtected: _isManualProtected,
        blurType: _selectedBlurType,
        blurStrength: 15.0,
        overlayColor: Colors.black.withValues(alpha: 0.5),
        animationDuration: const Duration(milliseconds: 400),
        privacyChild: _buildPrivacyOverlay(),
        child: _buildMainContent(),
      ),
      bottomNavigationBar: _buildControlPanel(),
    );
  }

  /// Privacy overlay content
  Widget _buildPrivacyOverlay() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.lock_person_rounded, color: Colors.white, size: 80),
        SizedBox(height: 16),
        Text(
          "SECURE MODE ACTIVE",
          style: TextStyle(
            color: Colors.white, 
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  /// Main content of the app (profile info, etc.)
  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text("Faysal Ahammed", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const Text("Senior Flutter Developer", style: TextStyle(color: Colors.grey, fontSize: 16)),
          const Divider(height: 50),
          
          _buildInfoTile(Icons.credit_card, "Bank Account", "**** **** **** 8890"),
          _buildInfoTile(Icons.phone_android, "Phone Number", "+880 123 456 789"),
          _buildInfoTile(Icons.location_on, "Private Address", "Shariatpur, Bangladesh"),
          
          const SizedBox(height: 30),
          const Card(
            color: Colors.amberContainer,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(width: 10),
                  Expanded(child: Text("Minimize the app to see the auto-blur effect in action!")),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Control panel with new features: global controller toggle, blur type selection, and manual switch
  Widget _buildControlPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Real-time Controls", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Global controller toggle button
              ElevatedButton.icon(
                onPressed: () => _privacyController.toggle(),
                icon: const Icon(Icons.Settings_remote),
                label: const Text("Controller"),
              ),
              // Style selector for blur type
              DropdownButton<PrivacyBlurType>(
                value: _selectedBlurType,
                items: PrivacyBlurType.values.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type.name.toUpperCase()));
                }).toList(),
                onChanged: (val) => setState(() => _selectedBlurType = val!),
              ),
              // Manual toggle switch for protection
              Switch(
                value: _isManualProtected,
                onChanged: (val) => setState(() => _isManualProtected = val),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}