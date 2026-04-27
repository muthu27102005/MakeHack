import 'package:flutter/material.dart';
import 'package:kalai_mobile/utils/theme.dart';
import 'package:kalai_mobile/utils/text_theme.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: Row(children: [Image.asset('assets/images/kalai_logo.jpg', height: 32), const SizedBox(width: 8), const Text('Admin Operations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]),
        backgroundColor: KalaiTheme.brown,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard('Total Products', '124', Icons.inventory, KalaiTheme.terracotta),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard('Verified Artisans', '89', Icons.verified, KalaiTheme.green),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('Pending Approvals', style: ThemeText.subhead),
            const SizedBox(height: 16),
            _buildApprovalTile('Meenakshi', 'Kanchipuram', 'Weaving'),
            _buildApprovalTile('Ram', 'Thanjavur', 'Bronze Casting'),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 16),
          Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: KalaiTheme.brown)),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildApprovalTile(String name, String village, String craft) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: KalaiTheme.gold, width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: KalaiTheme.cream, child: Text(name[0], style: const TextStyle(color: KalaiTheme.terracotta))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: KalaiTheme.brown)),
                Text('$village • $craft', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: KalaiTheme.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Approve', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
