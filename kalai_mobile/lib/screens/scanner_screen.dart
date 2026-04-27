import 'package:flutter/material.dart';
import 'package:kalai_mobile/utils/theme.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(children: [Image.asset('assets/images/kalai_logo.jpg', height: 32), const SizedBox(width: 8), const Text('Scan Product QR', style: TextStyle(fontSize: 18))]),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Mock Camera View
          Container(
            color: Colors.grey.shade900,
            child: const Center(
              child: Icon(Icons.qr_code_scanner_rounded, size: 200, color: Colors.white24),
            ),
          ),
          // Viewport Frame
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: KalaiTheme.gold, width: 4),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          Positioned(
            bottom: 50,
            child: ElevatedButton(
              onPressed: () {
                // Mock scanning success -> navigate to verify page
                Navigator.pushReplacementNamed(context, '/verify');
              },
              style: ElevatedButton.styleFrom(backgroundColor: KalaiTheme.terracotta, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16)),
              child: const Text('Simulate Scan Success', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }
}
