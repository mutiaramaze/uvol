import 'package:flutter/material.dart';

Widget _buildHeader(Map<String, dynamic> userStats) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome back,",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  "${userStats['name']}! 👋",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            "3",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Quick Stats
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // _statCard(Icons.emoji_events, "${userStats['eventsJoined']}", "Events"),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFeaturedOpportunities(List<Map<String, dynamic>> opportunities) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Kegiatan",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Column(
          children: opportunities.map((op) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        op['image']!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: (op['color'] as Color).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            op['category'],
                            style: TextStyle(
                              color: op['color'] as Color,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          op['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          op['organization'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                  size: 14,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  op['location'],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.people,
                                  color: Colors.blue,
                                  size: 14,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  "${op['volunteers']} joined",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Colors.blue,
                              size: 14,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              op['time'],
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.blue,
                              size: 14,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              op['date'],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}
