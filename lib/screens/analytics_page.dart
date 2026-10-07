import 'package:flutter/material.dart';

import '../models/customer_event.dart';
import '../services/api_service.dart';
import '../widgets/info_card.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  static final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analitik'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<AnalyticsSummary>(
        future: _apiService.fetchAnalyticsSummary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Gagal memuat data analitik.'));
          }

          final summary = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Analitik Pengunjung',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ringkasan data kepadatan pengunjung',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              InfoCard(
                title: 'Rata-rata Pengunjung',
                value: summary.averageVisitors,
                icon: Icons.people,
              ),
              InfoCard(
                title: 'Jam Paling Ramai',
                value: summary.busiestHour,
                icon: Icons.access_time,
              ),
              InfoCard(
                title: 'Kepadatan Tertinggi',
                value: summary.highestDensity,
                icon: Icons.trending_up,
              ),
              InfoCard(
                title: 'Kepadatan Terendah',
                value: summary.lowestDensity,
                icon: Icons.trending_down,
              ),
            ],
          );
        },
      ),
    );
  }
}
