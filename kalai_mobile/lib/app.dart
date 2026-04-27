import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalai_mobile/models/product_model.dart';
import 'package:kalai_mobile/services/blockchain_service.dart';
import 'package:kalai_mobile/services/product_service.dart';
import 'package:kalai_mobile/utils/constants.dart';
import 'package:kalai_mobile/utils/theme.dart';
import 'package:kalai_mobile/screens/splash_screen.dart';
import 'package:kalai_mobile/screens/welcome_screen.dart';
import 'package:kalai_mobile/screens/login_screen.dart';
import 'package:kalai_mobile/screens/signup_screen.dart';
import 'package:kalai_mobile/screens/scanner_screen.dart';
import 'package:kalai_mobile/screens/admin_dashboard.dart';
import 'package:kalai_mobile/screens/artisan_dashboard.dart';
import 'package:kalai_mobile/screens/verify_screen.dart';
import 'package:kalai_mobile/screens/add_product_screen.dart';
class KalaiApp extends StatelessWidget {
  const KalaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: KalaiAppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: KalaiTheme.lightTheme,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const KalaiHomePage(),
        '/scan': (context) => const ScannerScreen(),
        '/admin_dashboard': (context) => const AdminDashboard(),
        '/artisan_dashboard': (context) => const ArtisanDashboard(),
        '/verify': (context) => const VerifyScreen(),
        '/add_product': (context) => const AddProductScreen(),
      },
    );
  }
}

class KalaiHomePage extends StatefulWidget {
  const KalaiHomePage({super.key});

  @override
  State<KalaiHomePage> createState() => _KalaiHomePageState();
}

class _KalaiHomePageState extends State<KalaiHomePage> {
  final ProductService _productService = ProductService();
  final BlockchainService _blockchainService = BlockchainService();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _materialsController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _artisanController = TextEditingController(text: 'ARTISAN-001');
  final _gpsController = TextEditingController(text: '10.7905,79.1328');

  bool _saving = false;
  String _status = 'Ready';
  String _lastHash = 'No notarization yet';

  @override
  void initState() {
    super.initState();
    _productService.loadProducts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _materialsController.dispose();
    _descriptionController.dispose();
    _artisanController.dispose();
    _gpsController.dispose();
    super.dispose();
  }

  Future<void> _submitProduct() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _saving = true;
      _status = 'Saving product...';
    });

    final product = Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      category: _categoryController.text.trim(),
      materials: _materialsController.text
          .split(',')
          .map((value) => value.trim())
          .where((value) => value.isNotEmpty)
          .toList(),
      description: _descriptionController.text.trim(),
      gpsLocation: _gpsController.text.trim(),
      artisanId: _artisanController.text.trim(),
      status: 'pending',
    );

    final savedProduct = await _productService.addProduct(product);
    final blockchainHash = await _blockchainService.registerProduct(savedProduct);
    await _productService.updateBlockchainHash(savedProduct.id, blockchainHash);

    setState(() {
      _saving = false;
      _status = 'Registered with hash ${blockchainHash.substring(0, min(10, blockchainHash.length))}...';
      _lastHash = blockchainHash;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product saved and notarized: ${savedProduct.name}')),
    );
  }

  Future<void> _seedDemoProduct() async {
    final product = Product(
      id: 'demo-${DateTime.now().millisecondsSinceEpoch}',
      name: 'Demo Bronze Nataraja',
      category: 'Bronze Casting',
      materials: const ['Bronze', 'Wax'],
      description: 'Demo product used for the hackathon round.',
      gpsLocation: '10.7905,79.1328',
      artisanId: 'ARTISAN-001',
      status: 'verified',
      blockchainHash: 'demo-hash',
    );
    await _productService.addProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/kalai_logo.jpg', height: 40),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(_status, style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white70)),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(top: -40, right: -30, child: _Glow(size: 170, color: KalaiTheme.terracotta.withOpacity(0.14))),
          Positioned(bottom: 120, left: -20, child: _Glow(size: 150, color: KalaiTheme.gold.withOpacity(0.1))),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Hero(status: _status, lastHash: _lastHash),
                  const SizedBox(height: 12),
                  ValueListenableBuilder<List<Product>>(
                    valueListenable: _productService.products,
                    builder: (context, products, _) {
                      final total = products.length;
                      final verified = products.where((p) => p.status == 'verified').length;
                      return Row(
                        children: [
                          Expanded(child: _Metric(label: 'Total', value: '$total')),
                          const SizedBox(width: 8),
                          Expanded(child: _Metric(label: 'Verified', value: '$verified')),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  _Panel(
                    title: 'Register Product',
                    subtitle: 'Add details and generate blockchain proof hash.',
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _field(_nameController, 'Product name', Icons.shopping_bag_outlined),
                          const SizedBox(height: 10),
                          _field(_categoryController, 'Category', Icons.category_outlined),
                          const SizedBox(height: 10),
                          _field(_materialsController, 'Materials (comma separated)', Icons.layers_outlined),
                          const SizedBox(height: 10),
                          _field(_descriptionController, 'Description', Icons.description_outlined, maxLines: 3),
                          const SizedBox(height: 10),
                          _field(_gpsController, 'GPS location', Icons.place_outlined),
                          const SizedBox(height: 10),
                          _field(_artisanController, 'Artisan ID', Icons.badge_outlined),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _saving ? null : _seedDemoProduct,
                                  icon: const Icon(Icons.auto_awesome),
                                  label: const Text('Seed Demo'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _saving ? null : _submitProduct,
                                  icon: _saving
                                      ? const SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                        )
                                      : const Icon(Icons.shield_outlined),
                                  label: Text(_saving ? 'Saving...' : 'Save + Notarize'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _Panel(
                    title: 'Live Ledger',
                    subtitle: 'Latest products with verification status.',
                    child: ValueListenableBuilder<List<Product>>(
                      valueListenable: _productService.products,
                      builder: (context, products, _) {
                        if (products.isEmpty) {
                          return const Text('No products yet', style: TextStyle(color: Colors.white70));
                        }
                        return Column(
                          children: products
                              .map((product) => Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: _ProductCard(product: product),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
    );
  }
}

class _Glow extends StatelessWidget {
  final double size;
  final Color color;

  const _Glow({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final String status;
  final String lastHash;

  const _Hero({required this.status, required this.lastHash});

  @override
  Widget build(BuildContext context) {
    final shortHash = lastHash == 'No notarization yet' ? 'Waiting' : '${lastHash.substring(0, min(lastHash.length, 14))}...';

    return _Panel(
      title: 'Artisan Provenance Studio',
      subtitle: 'Capture data, hash it, verify it.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _Tag(text: 'MongoDB'),
              _Tag(text: 'Blockchain Hash'),
              _Tag(text: 'Mobile Demo'),
            ],
          ),
          const SizedBox(height: 10),
          Text('Status: $status', style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 4),
          Text('Last hash: $shortHash', style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;

  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Text(text, style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
    );
  }
}

class _Panel extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _Panel({required this.title, required this.subtitle, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 10),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;

  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(product.name, style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: product.status == 'verified' ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(product.status.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('Category: ${product.category}', style: const TextStyle(color: Colors.white70)),
          Text('GPS: ${product.gpsLocation}', style: const TextStyle(color: Colors.white70)),
          Text('Hash: ${product.blockchainHash ?? 'pending'}', style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
