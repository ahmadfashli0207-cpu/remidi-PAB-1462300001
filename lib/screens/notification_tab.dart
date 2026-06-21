import 'package:flutter/material.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({super.key});

  final List<Map<String, dynamic>> _notifications = const [
    {
      'icon': Icons.rocket_launch,
      'color': Color(0xFF1E88E5),
      'title': 'Peluncuran SpaceX Falcon 9 Berhasil',
      'desc': 'SpaceX berhasil meluncurkan Falcon 9 membawa 22 satelit Starlink ke orbit rendah Bumi.',
      'time': '2 jam lalu',
    },
    {
      'icon': Icons.star,
      'color': Color(0xFFFFC107),
      'title': 'NASA Temukan Eksoplanet Baru',
      'desc': 'Para ilmuwan NASA mengumumkan penemuan eksoplanet yang memiliki kondisi mirip Bumi.',
      'time': '5 jam lalu',
    },
    {
      'icon': Icons.public,
      'color': Color(0xFF4CAF50),
      'title': 'ISS Rayakan 25 Tahun Beroperasi',
      'desc': 'Stasiun Luar Angkasa Internasional merayakan seperempat abad kehadirannya di orbit.',
      'time': '1 hari lalu',
    },
    {
      'icon': Icons.satellite_alt,
      'color': Color(0xFFE91E63),
      'title': 'Artemis III Siap Menuju Bulan',
      'desc': 'NASA mengumumkan jadwal misi Artemis III yang akan membawa astronot wanita pertama ke Bulan.',
      'time': '2 hari lalu',
    },
    {
      'icon': Icons.science,
      'color': Color(0xFF9C27B0),
      'title': 'Penemuan Air di Mars Dikonfirmasi',
      'desc': 'Misi Mars Reconnaissance Orbiter menemukan tanda-tanda air cair di bawah permukaan Mars.',
      'time': '3 hari lalu',
    },
    {
      'icon': Icons.blur_on,
      'color': Color(0xFFFF5722),
      'title': 'James Webb Tangkap Gambar Galaksi Jauh',
      'desc': 'Teleskop James Webb berhasil menangkap gambar galaksi yang terbentuk hanya 400 juta tahun setelah Big Bang.',
      'time': '4 hari lalu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text('Notifikasi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0D1117),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Tandai Semua', style: TextStyle(color: Color(0xFF1E88E5), fontSize: 12)),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notif = _notifications[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF161B27),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF2A3040)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: (notif['color'] as Color).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(notif['icon'] as IconData, color: notif['color'] as Color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notif['title']! as String, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(notif['desc']! as String, style: const TextStyle(color: Color(0xFF8D9BAB), fontSize: 12, height: 1.4), maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 6),
                      Text(notif['time']! as String, style: const TextStyle(color: Color(0xFF1E88E5), fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
