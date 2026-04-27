import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalai_mobile/utils/theme.dart';
import 'dart:ui';

class ArtisanDashboard extends StatefulWidget {
  const ArtisanDashboard({super.key});

  @override
  State<ArtisanDashboard> createState() => _ArtisanDashboardState();
}

class _ArtisanDashboardState extends State<ArtisanDashboard> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animController;
  
  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KalaiTheme.darkBg,
      body: Stack(
        children: [
          // Background Glowing Gradient Mesh
          Positioned(
            top: -100, left: -100,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.1).animate(_animController),
              child: Container(
                width: 300, height: 300,
                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF6A5ACD).withOpacity(0.3)),
              ),
            ),
          ),
          Positioned(
            bottom: -50, right: -50,
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(shape: BoxShape.circle, color: KalaiTheme.terracotta.withOpacity(0.2)),
            ),
          ),

          CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Lakshmi Devi',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text('🙏', style: TextStyle(fontSize: 24)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: KalaiTheme.green.withOpacity(0.3)),
                            boxShadow: [
                              BoxShadow(color: KalaiTheme.green.withOpacity(0.1), blurRadius: 10, spreadRadius: 2),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8, height: 8,
                                decoration: const BoxDecoration(
                                  color: KalaiTheme.green,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: KalaiTheme.green, blurRadius: 4)],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Verified Artisan',
                                style: GoogleFonts.dmSans(
                                  color: KalaiTheme.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Stats Row
              SliverPadding(
                padding: const EdgeInsets.all(24.0),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(child: _buildStatCard('🏺', '12', 'Products Listed', false)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildStatCard('✅', '11', 'Verified on Chain', true)),
                    ],
                  ),
                ),
              ),
              
              // Quick Actions
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'QUICK ACTIONS',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white54,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionCard(
                              icon: Icons.add,
                              iconColor: Colors.white,
                              title: 'Add Product',
                              subtitle: 'List new craft',
                              isPrimary: true,
                              onTap: () => Navigator.pushNamed(context, '/add_product'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildActionCard(
                              icon: Icons.qr_code_scanner,
                              iconColor: KalaiTheme.gold,
                              title: 'Scan QR',
                              subtitle: 'Verify product',
                              isPrimary: false,
                              onTap: () => Navigator.pushNamed(context, '/scan'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionCard(
                              icon: Icons.bar_chart,
                              iconColor: Colors.pinkAccent,
                              title: 'Analytics',
                              subtitle: 'Views & scans',
                              isPrimary: false,
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildActionCard(
                              icon: Icons.person,
                              iconColor: Colors.cyanAccent,
                              title: 'Profile',
                              subtitle: 'Edit details',
                              isPrimary: false,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              // Recent Products
              SliverPadding(
                padding: const EdgeInsets.all(24.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RECENT PRODUCTS',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white54,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 100, // Placeholder space to allow scrolling above bottom nav
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Custom Glass Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String emoji, String count, String label, bool highlight) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: highlight ? KalaiTheme.green.withOpacity(0.3) : Colors.white.withOpacity(0.1)),
            boxShadow: highlight ? [BoxShadow(color: KalaiTheme.green.withOpacity(0.1), blurRadius: 15)] : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 12),
              Text(
                count,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: highlight ? KalaiTheme.green : KalaiTheme.terracotta,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: isPrimary ? 0 : 15, sigmaY: isPrimary ? 0 : 15),
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isPrimary ? KalaiTheme.terracotta : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isPrimary ? Colors.transparent : Colors.white.withOpacity(0.1)),
              boxShadow: isPrimary ? [BoxShadow(color: KalaiTheme.terracotta.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))] : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 36,
                  color: iconColor,
                ),
                const Spacer(),
                Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: 85,
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C24).withOpacity(0.8),
            border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Home', 0),
                  _buildNavItem(Icons.inventory_2, 'Products', 1),
                  const SizedBox(width: 48), // Space for floating button
                  _buildNavItem(Icons.qr_code_scanner, 'Scan', 2),
                  _buildNavItem(Icons.person, 'Profile', 3),
                ],
              ),
              Positioned(
                top: -20,
                left: MediaQuery.of(context).size.width / 2 - 32,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/add_product'),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [KalaiTheme.terracotta, Color(0xFFFF8C00)]),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: KalaiTheme.terracotta.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 36),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? KalaiTheme.gold : Colors.white30;
    
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 10,
              color: color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


