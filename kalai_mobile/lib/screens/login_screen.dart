import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalai_mobile/utils/theme.dart';
import 'dart:ui';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KalaiTheme.darkBg,
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -100, right: -100,
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(shape: BoxShape.circle, color: KalaiTheme.terracotta.withOpacity(0.3)),
            ),
          ),
          
          Column(
            children: [
              // Header Let's not use a solid Expanded but a transparent SafeArea
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Text(
                        'KALAI',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = const LinearGradient(colors: [KalaiTheme.gold, Colors.white]).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to your artisan account',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Bottom Half - Glass Form
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.2))),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              initialValue: 'lakshmi@test.com',
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(labelText: 'EMAIL ADDRESS'),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              initialValue: 'password123',
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(labelText: 'PASSWORD'),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot password?',
                                  style: GoogleFonts.dmSans(
                                    color: KalaiTheme.gold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/artisan_dashboard');
                              },
                              child: const Text('Sign In →'),
                            ),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(child: Divider(color: Colors.white.withOpacity(0.2))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    'or',
                                    style: GoogleFonts.dmSans(color: Colors.white54),
                                  ),
                                ),
                                Expanded(child: Divider(color: Colors.white.withOpacity(0.2))),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'New artisan? ',
                                  style: GoogleFonts.dmSans(color: Colors.white70),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(context, '/signup'),
                                  child: Text(
                                    'Create account',
                                    style: GoogleFonts.dmSans(
                                      color: KalaiTheme.terracotta,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


