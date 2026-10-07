import 'package:flutter/material.dart';

import '../models/customer_event.dart';
import '../services/api_service.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  static final ApiService _apiService = ApiService();

  Color _statusColor(String status) {
    switch (status) {
      case 'SEPI':
        return Colors.green;
      case 'RAMAI':
        return Colors.orange;
      case 'SANGAT RAMAI':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<CustomerEvent>>(
        future: _apiService.fetchHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Gagal memuat riwayat.'));
          }

          final history = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final event = history[index];
              final statusColor = _statusColor(event.densityStatus);

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE3F2FD),
                    child: Icon(Icons.people, color: Color(0xFF1565C0)),
                  ),
                  title: Text(
                    '${event.customersInside} orang',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Waktu: ${event.time}'),
                  trailing: Text(
                    event.densityStatus,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
