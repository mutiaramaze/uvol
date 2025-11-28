import 'package:flutter/material.dart';
import 'package:uvol/features/admin/create_events.dart';
import 'package:uvol/features/admin/register_choice.dart';
import 'package:uvol/features/sqf/details/settings.dart';

class OrganizerPage extends StatelessWidget {
  const OrganizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 231, 248),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 221, 231, 248),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Organizer",
          style: TextStyle(
            color: Color(0xFF1A2340),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Settings()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => RegisterChoicePage(),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============================
            // HEADER ORGANISASI
            // ============================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(
                      Icons.event,
                      size: 40,
                      color: Color(0xFF4962BF),
                    ),
                  ),
                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Komunitas Sahabat Bumi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A2340),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Jakarta Selatan",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ============================
            // STATISTIK
            // ============================
            const Text(
              "Statistik",
              style: TextStyle(
                color: Color(0xFF1A2340),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                statCard("Total Event", "12", Icons.calendar_month),
                const SizedBox(width: 10),
                statCard("Event Aktif", "4", Icons.play_circle_fill),
                const SizedBox(width: 10),
                statCard("Pendaftar", "327", Icons.people),
              ],
            ),

            const SizedBox(height: 25),

            // ============================
            // MENU AKSI CEPAT
            // ============================
            const Text(
              "Aktivitas",
              style: TextStyle(
                color: Color(0xFF1A2340),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                expandedButton(
                  text: "Buat Event",
                  icon: Icons.add_circle,
                  color: const Color(0xFF4962BF),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CreateEvent()),
                    );
                  },
                ),

                const SizedBox(width: 10),
                expandedButton(
                  text: "Lihat Semua Event",
                  icon: Icons.list_alt,
                  color: Colors.orange.shade400,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ============================
            // EVENT TERBARU
            // ============================
            const Text(
              "Event Terbaru",
              style: TextStyle(
                color: Color(0xFF1A2340),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            eventItem(
              title: "Beach Cleanup Day",
              date: "28 November 2025",
              participants: 120,
              status: "Aktif",
            ),
            eventItem(
              title: "Penanaman Pohon",
              date: "14 Desember 2025",
              participants: 87,
              status: "Aktif",
            ),
            eventItem(
              title: "Donasi Buku Anak",
              date: "20 Januari 2026",
              participants: 56,
              status: "Selesai",
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ==================================================
  // WIDGET STAT CARD
  // ==================================================
  Widget statCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          children: [
            Icon(icon, color: Color(0xFF4962BF), size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF1A2340),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // ==================================================
  // WIDGET AKSI CEPAT
  // ==================================================
  Widget expandedButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 26),
              const SizedBox(height: 6),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================================================
  // WIDGET ITEM EVENT
  // ==================================================
  Widget eventItem({
    required String title,
    required String date,
    required int participants,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          Icon(Icons.event_available, size: 40, color: Color(0xFF4962BF)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1A2340),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                Text(
                  "$participants Pendaftar",
                  style: const TextStyle(
                    color: Color(0xFF4962BF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          statusBadge(status),
        ],
      ),
    );
  }

  Widget statusBadge(String status) {
    Color bg = Colors.grey;
    if (status == "Aktif") bg = Colors.green;
    if (status == "Selesai") bg = Colors.redAccent;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
