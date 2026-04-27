import 'package:flutter/material.dart';
import 'package:kalai_mobile/utils/theme.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(children: [Image.asset('assets/images/kalai_logo.jpg', height: 32), const SizedBox(width: 8), const Text('Product Verification', style: TextStyle(fontSize: 18))]),
        backgroundColor: KalaiTheme.brown,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: KalaiTheme.cream,
              child: const Icon(Icons.image, size: 100, color: KalaiTheme.terracotta),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kanchipuram Silk Sari',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: KalaiTheme.brown),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: KalaiTheme.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.verified, color: KalaiTheme.green),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('ID: KAL-0001', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Authenticity Proof'),
                  const SizedBox(height: 16),
                  _buildBlockchainCard(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Journey Timeline'),
                  const SizedBox(height: 16),
                  _buildTimelineItem('Registered by Artisan', 'Oct 14, 2026 - Kanchipuram, TN', isFirst: true),
                  _buildTimelineItem('Verified Quality Check', 'Oct 15, 2026 - Chennai Hub', isLast: true),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: KalaiTheme.terracotta,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('View Full Certificate'),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: KalaiTheme.brown),
    );
  }

  Widget _buildBlockchainCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.link, color: KalaiTheme.gold),
              SizedBox(width: 8),
              Text('Polygon Network', style: TextStyle(fontWeight: FontWeight.bold, color: KalaiTheme.brown)),
            ],
          ),
          const Divider(height: 24),
          _buildInfoRow('Artisan', 'Lakshmi'),
          const SizedBox(height: 8),
          _buildInfoRow('Village', 'Kanchipuram'),
          const SizedBox(height: 8),
          _buildInfoRow('Tx Hash', '0x8f...3a9c'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: KalaiTheme.brown)),
      ],
    );
  }

  Widget _buildTimelineItem(String title, String subtitle, {bool isFirst = false, bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: KalaiTheme.terracotta,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: KalaiTheme.terracotta.withOpacity(0.3),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: KalaiTheme.brown)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 24),
            ],
          ),
        )
      ],
    );
  }
}
