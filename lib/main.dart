import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const SmartCustomerApp());
}

class SmartCustomerApp extends StatelessWidget {
  const SmartCustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Customer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
      ),
      home: const MainNavigation(),
    );
  }
}

// ======================================================
// NAVIGASI UTAMA
// ======================================================

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  final pages = const [
    DashboardPage(),
    AnalyticsPage(),
    HistoryPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Analitik',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

// ======================================================
// DASHBOARD
// ======================================================

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentVisitors = 28;
  int totalEntry = 35;
  int totalExit = 7;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    // Simulasi data real-time
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        setState(() {
          currentVisitors++;

          if (currentVisitors >= 40) {
            currentVisitors = 20;
          }

          totalEntry++;
        });
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String getDensityStatus() {
    if (currentVisitors <= 10) {
      return 'SEPI';
    } else if (currentVisitors <= 25) {
      return 'NORMAL';
    } else if (currentVisitors <= 35) {
      return 'RAMAI';
    } else {
      return 'SANGAT RAMAI';
    }
  }

  Color getDensityColor() {
    switch (getDensityStatus()) {
      case 'SEPI':
        return Colors.green;
      case 'NORMAL':
        return Colors.blue;
      case 'RAMAI':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  double getCapacityPercentage() {
    return currentVisitors / 40;
  }

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF1565C0);
    const textDark = Color(0xFF152033);
    const muted = Color(0xFF657184);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Smart Customer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            Text(
              'Monitoring Minimarket',
              style: TextStyle(
                fontSize: 12,
                color: muted,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: textDark,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Pemantauan kepadatan pengunjung secara real-time',
              style: TextStyle(
                color: muted,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 18),

            // ==========================================
            // MONITORING CARD
            // ==========================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'MONITORING REAL-TIME',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.greenAccent,
                              size: 9,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'LIVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Pengunjung Saat Ini',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$currentVisitors',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'orang',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: getCapacityPercentage().clamp(0, 1),
                      minHeight: 10,
                      backgroundColor: Colors.white30,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Text(
                        'Kapasitas maksimal 40 orang',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${(getCapacityPercentage() * 100).round()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: getDensityColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Status: ${getDensityStatus()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ==========================================
            // STAT CARD
            // ==========================================

            Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.login,
                    title: 'Masuk Hari Ini',
                    value: '$totalEntry',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.logout,
                    title: 'Keluar Hari Ini',
                    value: '$totalExit',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: const [
                Expanded(
                  child: StatCard(
                    icon: Icons.groups,
                    title: 'Kapasitas',
                    value: '40',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.sensors,
                    title: 'Sensor',
                    value: 'Online',
                    valueColor: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ==========================================
            // TREND
            // ==========================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tren Pengunjung',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Data pengunjung beberapa jam terakhir',
                    style: TextStyle(
                      fontSize: 12,
                      color: muted,
                    ),
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    height: 180,
                    child: CustomPaint(
                      painter: VisitorChartPainter(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ==========================================
            // SYSTEM STATUS
            // ==========================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status Sistem',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 15),

                  StatusItem(
                    label: 'Internet',
                    value: 'Terhubung',
                    color: Colors.green,
                  ),

                  StatusItem(
                    label: 'ESP32',
                    value: 'Online',
                    color: Colors.green,
                  ),

                  StatusItem(
                    label: 'Sensor',
                    value: 'Aktif',
                    color: Colors.green,
                  ),

                  StatusItem(
                    label: 'Update terakhir',
                    value: 'Real-Time',
                    color: Colors.blue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// STAT CARD
// ======================================================

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color valueColor;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor = const Color(0xFF152033),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF1565C0),
            size: 25,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF657184),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// STATUS ITEM
// ======================================================

class StatusItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const StatusItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.circle,
                color: color,
                size: 9,
              ),
              const SizedBox(width: 6),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ======================================================
// CHART
// ======================================================

class VisitorChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    final linePaint = Paint()
      ..color = const Color(0xFF1565C0)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final dotPaint = Paint()
      ..color = const Color(0xFF1565C0);

    final values = [
      10.0,
      14.0,
      11.0,
      21.0,
      27.0,
      24.0,
      28.0,
    ];

    const maxValue = 40.0;

    final left = 10.0;
    final right = size.width - 10;
    final top = 10.0;
    final bottom = size.height - 25;

    for (int i = 0; i < 5; i++) {
      final y = top + (bottom - top) * i / 4;

      canvas.drawLine(
        Offset(left, y),
        Offset(right, y),
        gridPaint,
      );
    }

    final points = <Offset>[];

    for (int i = 0; i < values.length; i++) {
      final x = left +
          (right - left) * i / (values.length - 1);

      final y = bottom -
          values[i] / maxValue * (bottom - top);

      points.add(
        Offset(x, y),
      );
    }

    final path = Path();

    path.moveTo(
      points.first.dx,
      points.first.dy,
    );

    for (int i = 1; i < points.length; i++) {
      path.lineTo(
        points[i].dx,
        points[i].dy,
      );
    }

    canvas.drawPath(
      path,
      linePaint,
    );

    for (final point in points) {
      canvas.drawCircle(
        point,
        5,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}

// ======================================================
// ANALYTICS PAGE
// ======================================================

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analitik'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Analitik Pengunjung',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Ringkasan data kepadatan pengunjung',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          const InfoCard(
            title: 'Rata-rata Pengunjung',
            value: '24 orang',
            icon: Icons.people,
          ),

          const InfoCard(
            title: 'Jam Paling Ramai',
            value: '10:00 - 11:00',
            icon: Icons.access_time,
          ),

          const InfoCard(
            title: 'Kepadatan Tertinggi',
            value: '35 orang',
            icon: Icons.trending_up,
          ),

          const InfoCard(
            title: 'Kepadatan Terendah',
            value: '8 orang',
            icon: Icons.trending_down,
          ),
        ],
      ),
    );
  }
}

// ======================================================
// HISTORY PAGE
// ======================================================

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      ['10:00', '28', 'RAMAI'],
      ['09:00', '22', 'NORMAL'],
      ['08:00', '16', 'NORMAL'],
      ['07:00', '12', 'NORMAL'],
      ['06:00', '8', 'SEPI'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final data = history[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE3F2FD),
                child: Icon(
                  Icons.people,
                  color: Color(0xFF1565C0),
                ),
              ),
              title: Text(
                '${data[1]} orang',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Waktu: ${data[0]}',
              ),
              trailing: Text(
                data[2],
                style: TextStyle(
                  color: data[2] == 'RAMAI'
                      ? Colors.orange
                      : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ======================================================
// SETTINGS PAGE
// ======================================================

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profil Admin'),
            subtitle: const Text('Administrator'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifikasi'),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            leading: const Icon(Icons.sensors),
            title: const Text('Status Sensor'),
            subtitle: const Text('ESP32 Online'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Aplikasi'),
            subtitle: const Text('Smart Customer v1.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ======================================================
// INFO CARD
// ======================================================

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE3F2FD),
          child: Icon(
            icon,
            color: const Color(0xFF1565C0),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(value),
      ),
    );
  }
}