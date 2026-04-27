import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalai_mobile/utils/theme.dart';
import 'package:kalai_mobile/utils/text_theme.dart';
import 'dart:ui';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Breathtaking Mesh Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.5, -0.6),
                radius: 1.5,
                colors: [
                  Color(0xFF2A1110), // Deep Terracotta tint
                  KalaiTheme.darkBg,
                  Color(0xFF1A1A24),
                ],
              ),
            ),
          ),
          
          // Glowing Animated Orbs
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            right: -50,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 200, height: 200,
                decoration: BoxDecoration(shape: BoxShape.circle, color: KalaiTheme.terracotta.withOpacity(0.4)),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            left: -50,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 250, height: 250,
                decoration: BoxDecoration(shape: BoxShape.circle, color: KalaiTheme.gold.withOpacity(0.2)),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'KALAI',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = const LinearGradient(colors: [KalaiTheme.gold, Colors.white]).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'கலை · The Future of Authentic Handcraft',
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 48),
                        _buildGlassChip('🏺 Pottery'),
                        const SizedBox(height: 16),
                        _buildGlassChip('🧵 Master Weaving'),
                        const SizedBox(height: 16),
                        _buildGlassChip('🪬 Temple Jewellery'),
                      ],
                    ),
                  ),
                ),
                
                // Bottom Glass Panel
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.2), width: 1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Blockchain Trust\nfor the World.',
                              style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white, height: 1.2),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, '/login'),
                              child: const Text('Continue as Artisan'),
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: () => Navigator.pushNamed(context, '/scan'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(color: Colors.white.withOpacity(0.3)),
                              ),
                              icon: const Icon(Icons.qr_code_scanner),
                              label: const Text('Scan a Product'),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(context, '/admin_dashboard'),
                              child: Text('Admin Login', style: GoogleFonts.dmSans(color: Colors.white54, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassChip(String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Text(
            label,
            style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ),
    );
  }
}

