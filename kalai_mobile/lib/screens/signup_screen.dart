import 'package:flutter/material.dart';
import 'package:kalai_mobile/utils/theme.dart';
import 'package:kalai_mobile/utils/text_theme.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KalaiTheme.cream,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: KalaiTheme.terracotta)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.person_add_alt_1_rounded, size: 60, color: KalaiTheme.terracotta),
            const SizedBox(height: 16),
            Text('Join Kalai', textAlign: TextAlign.center, style: ThemeText.headline),
            const SizedBox(height: 32),
            _buildTextField('Full Name'),
            const SizedBox(height: 16),
            _buildTextField('Email Address'),
            const SizedBox(height: 16),
            _buildTextField('Password', obscure: true),
            const SizedBox(height: 16),
            _buildTextField('Village Name'),
            const SizedBox(height: 16),
            _buildTextField('Craft Speciality (e.g., Weaving, Pottery)'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/artisan_dashboard');
              },
              style: ElevatedButton.styleFrom(backgroundColor: KalaiTheme.terracotta, padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool obscure = false}) {
    return TextFormField(
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
