import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalai_mobile/utils/theme.dart';
import 'dart:ui';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  void _showHashingDemo() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _HashingDemoModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KalaiTheme.darkBg,
      appBar: AppBar(
        title: Row(children: [Image.asset('assets/images/kalai_logo.jpg', height: 32), const SizedBox(width: 8), const Text('Add Product', style: TextStyle(fontSize: 18))]),
      ),
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: 100, right: -50,
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(shape: BoxShape.circle, color: KalaiTheme.terracotta.withOpacity(0.2)),
            ),
          ),
          Positioned(
            bottom: 50, left: -50,
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(shape: BoxShape.circle, color: KalaiTheme.green.withOpacity(0.15)),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stepper Glow
                  Row(
                    children: [
                      Container(width: 12, height: 12, decoration: const BoxDecoration(color: KalaiTheme.green, shape: BoxShape.circle, boxShadow: [BoxShadow(color: KalaiTheme.green, blurRadius: 8)])),
                      const SizedBox(width: 8),
                      Container(width: 40, height: 6, decoration: BoxDecoration(color: KalaiTheme.terracotta, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: KalaiTheme.terracotta, blurRadius: 4)])),
                      const SizedBox(width: 8),
                      Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  _buildPhotoUpload(),
                  const SizedBox(height: 24),
                  
                  _buildLabel('PRODUCT NAME'),
                  const SizedBox(height: 8),
                  _buildTextField('e.g. Thanjavur Bronze Nataraja'),
                  const SizedBox(height: 20),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('CATEGORY'),
                            const SizedBox(height: 8),
                            _buildTextField('Bronze Casting'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('MATERIALS'),
                            const SizedBox(height: 8),
                            _buildTextField('Bronze, Brass'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  _buildLabel('DESCRIPTION'),
                  const SizedBox(height: 8),
                  _buildTextField('Traditional Chola-era casting technique...', maxLines: 3),
                  const SizedBox(height: 24),
                  
                  _buildLocationCapture(),
                  const SizedBox(height: 48),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _showHashingDemo,
                      icon: const Icon(Icons.link),
                      label: const Text('Register on Blockchain'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white54,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildPhotoUpload() {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 180,
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: KalaiTheme.gold.withOpacity(0.5), width: 1.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: KalaiTheme.gold.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt, size: 40, color: KalaiTheme.gold),
                ),
                const SizedBox(height: 16),
                Text('Scan or Upload Artifact', style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCapture() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pinkAccent.withOpacity(0.5)),
                ),
                child: const Icon(Icons.location_on, color: Colors.pinkAccent),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('GPS Location', style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, color: Colors.white)),
                    Text('10.7905° N, 79.1328° E', style: GoogleFonts.dmSans(color: KalaiTheme.gold, fontSize: 12)),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white.withOpacity(0.3)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}

// Simulated Hacker-Matrix Blockchain Demo
class _HashingDemoModal extends StatefulWidget {
  const _HashingDemoModal();

  @override
  State<_HashingDemoModal> createState() => _HashingDemoModalState();
}

class _HashingDemoModalState extends State<_HashingDemoModal> {
  int _step = 0;

  @override
  void initState() {
    super.initState();
    _playDemo();
  }

  void _playDemo() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if(mounted) setState(() => _step = 1);
    await Future.delayed(const Duration(milliseconds: 2500));
    if(mounted) setState(() => _step = 2);
    await Future.delayed(const Duration(milliseconds: 3000));
    if(mounted) setState(() => _step = 3);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F13).withOpacity(0.9), // Extremely dark glass
            border: Border(top: BorderSide(color: KalaiTheme.green.withOpacity(0.5), width: 2)),
          ),
          padding: const EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.security, color: KalaiTheme.green, size: 28),
                  const SizedBox(width: 12),
                  Text('On-Chain Verification', style: GoogleFonts.dmSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1)),
                ],
              ),
              const SizedBox(height: 24),
              
              if (_step >= 0) _buildLogLine('[1/3] Generating Standardized JSON Payload...', Colors.cyan),
              if (_step >= 0) _buildCodeSnippet('{\n  "artisanId": "kal-7892",\n  "product": "Nataraja Bronze",\n  "gps": "10.79, 79.13"\n}'),
              
              const SizedBox(height: 16),
              if (_step >= 1) _buildLogLine('[2/3] Executing SHA-256 Cryptographic Hash...', KalaiTheme.gold),
              if (_step >= 1) _buildCodeSnippet('HASH: 0x8f434346648e58a2b5...\nMATCH: Valid. No alterations detected.'),
              
              const SizedBox(height: 16),
              if (_step >= 2) _buildLogLine('[3/3] Minting to Polygon Amoy Network...', KalaiTheme.green),
              if (_step >= 2) _buildLogLine('Awaiting Smart Contract Confirmation...', Colors.grey),
              
              const SizedBox(height: 16),
              if (_step >= 3) _buildLogLine('✓ PERMANENTLY REGISTERED TO LEDGER', const Color(0xFF00FF7F)),
              if (_step >= 3) _buildCodeSnippet('TxHash: 0xab12c9...def3\nNetwork: Polygon PoS'),

              const SizedBox(height: 32),
              if (_step >= 3)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context); // Go back to dashboard on success
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KalaiTheme.green,
                      shadowColor: KalaiTheme.green.withOpacity(0.5),
                    ),
                    child: const Text('Complete Verification', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogLine(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.terminal, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: GoogleFonts.dmSans(color: color, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildCodeSnippet(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8, bottom: 8, left: 26),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green.withOpacity(0.2))),
      child: Text(code, style: const TextStyle(fontFamily: 'monospace', color: Color(0xFF00FF7F), fontSize: 13, height: 1.5)),
    );
  }
}

