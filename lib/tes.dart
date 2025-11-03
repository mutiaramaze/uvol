import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userStats = {
      'name': 'Sarah',
      'level': 'Gold Volunteer',
      'totalHours': 124,
      'eventsJoined': 18,
      'impactPoints': 850,
      'currentStreak': 12,
    };

    final upcomingEvents = [
      {
        'title': 'Beach Cleanup Day',
        'organization': 'Ocean Conservation',
        'date': 'Nov 2',
        'time': '7:00 AM',
        'image':
            'https://images.unsplash.com/photo-1582108909833-7b908eb5fb29?auto=format&w=1080',
        'urgent': true,
      },
      {
        'title': 'Food Distribution',
        'organization': 'Hope Kitchen',
        'date': 'Nov 5',
        'time': '9:00 AM',
        'image':
            'https://images.unsplash.com/photo-1593113702251-272b1bc414a9?auto=format&w=1080',
        'urgent': false,
      },
    ];

    final categories = [
      {
        'emoji': '🌱',
        'label': 'Environment',
        'count': 24,
        'color': Colors.green,
      },
      {'emoji': '📚', 'label': 'Education', 'count': 18, 'color': Colors.blue},
      {'emoji': '🍽️', 'label': 'Food', 'count': 32, 'color': Colors.orange},
      {'emoji': '❤️', 'label': 'Health', 'count': 15, 'color': Colors.red},
      {
        'emoji': '🏘️',
        'label': 'Community',
        'count': 20,
        'color': Colors.purple,
      },
      {'emoji': '🐾', 'label': 'Animals', 'count': 12, 'color': Colors.pink},
    ];

    final featuredOpportunities = [
      {
        'title': 'Community Food Drive',
        'organization': 'Local Food Bank',
        'image':
            'https://images.unsplash.com/photo-1593113702251-272b1bc414a9?auto=format&w=1080',
        'location': 'Downtown Center',
        'date': 'Nov 10, 2025',
        'time': '2 hours',
        'volunteers': 12,
        'category': 'Food',
        'color': Colors.orange,
        'rating': 4.8,
        'difficulty': 'Easy',
      },
      {
        'title': 'Tree Planting Campaign',
        'organization': 'Green Earth Foundation',
        'image':
            'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?auto=format&w=1080',
        'location': 'City Park',
        'date': 'Nov 15, 2025',
        'time': '3 hours',
        'volunteers': 30,
        'category': 'Environment',
        'color': Colors.green,
        'rating': 4.9,
        'difficulty': 'Medium',
      },
      {
        'title': 'Youth Mentoring Program',
        'organization': 'Education First',
        'image':
            'https://images.unsplash.com/photo-1652811435172-bf8bbe203469?auto=format&w=1080',
        'location': 'Community Library',
        'date': 'Nov 20, 2025',
        'time': '4 hours',
        'volunteers': 8,
        'category': 'Education',
        'color': Colors.blue,
        'rating': 5.0,
        'difficulty': 'Easy',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            _buildHeader(userStats, weeklyGoal),

            // SEARCH BAR
            _buildSearchBar(),

            // QUICK ACTIONS (bonus mini section)
            _buildQuickActions(),

            // CATEGORIES
            _buildCategories(categories),

            // UPCOMING EVENTS
            _buildUpcomingEvents(upcomingEvents),

            // FEATURED OPPORTUNITIES
            _buildFeaturedOpportunities(featuredOpportunities),
          ],
        ),
      ),
    );
  }

  // =====================
  // === HEADER SECTION ===
  // =====================

  // =====================
  // === SEARCH BAR ===
  // =====================
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search volunteer opportunities...",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Container(
            margin: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
              ),
            ),
            child: const Icon(Icons.filter_list, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // =====================
  // === QUICK ACTIONS ===
  // =====================
  Widget _buildQuickActions() {
    final quickActions = [
      {
        'icon': LucideIcons.search,
        'label': 'Find Events',
        'color': Colors.blue,
      },
      {
        'icon': LucideIcons.calendar,
        'label': 'My Schedule',
        'color': Colors.green,
      },
      {
        'icon': LucideIcons.award,
        'label': 'Certificates',
        'color': Colors.amber,
      },
      {'icon': LucideIcons.users, 'label': 'Community', 'color': Colors.purple},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: quickActions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final a = quickActions[index];
          return Column(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: a['color'] as Color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  a['icon'] as IconData,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                a['label'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.black87),
              ),
            ],
          );
        },
      ),
    );
  }

  // =====================
  // === CATEGORIES ===
  // =====================
  Widget _buildCategories(List<Map<String, dynamic>> categories) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Browse by Category",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final c = categories[index];
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: (c['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            c['emoji'] as String,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            c['label'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: c['color'] as Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${c['count']}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // =====================
  // === UPCOMING EVENTS ===
  // =====================
  Widget _buildUpcomingEvents(List<Map<String, dynamic>> events) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Upcoming Events",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Column(
            children: events.map((event) {
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      event['image']!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    event['title']!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text("${event['organization']} • ${event['date']}"),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ==========================
  // === FEATURED OPPORTUNITIES ===
  // ==========================

  // =====================
  // === SMALL STAT CARD ===
  // =====================
  Widget _statCard(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
      ],
    );
  }
}
