import 'package:flutter/material.dart';
import 'package:uvol/database/firebase/models/detail_model_firebase.dart';
import 'package:uvol/database/model/events.model.dart';
import 'package:uvol/extensions/drive_image_extension.dart';
import 'package:uvol/features/firebase/details/question_events_firebase.dart';
import 'package:uvol/widgets/widget_%20detail.dart';

class TapEventsFirebase extends StatelessWidget {
  final DetailModelFirebase event;
  const TapEventsFirebase({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: _buildImage(event.image),
                ),
                Positioned(
                  top: 40,
                  left: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _buildDetail(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      final eventData = EventsModel(
                        title: event.title,
                        date: event.date,
                        location: event.location,
                        image: event.image,
                        category: event.category,
                        about: event.about,
                        requirements: event.requirements,
                        benefits: event.benefits,
                        positions: event.positions,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              QuestionEventsFirebase(event: eventData),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    child: const Text(
                      "Daftar",
                      style: TextStyle(
                        color: Color(0xFF065EA7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildImage(String? image) {
    if (image == null || image.isEmpty) {
      return Container(
        color: Colors.grey.shade300,
        child: const Icon(Icons.image_not_supported, size: 80),
      );
    }

    final fixedUrl = image.driveImageUrl;

    if (fixedUrl.isEmpty) {
      return Container(
        color: Colors.grey.shade300,
        child: const Icon(Icons.folder_off, size: 80),
      );
    }

    return Image.network(
      fixedUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: Colors.grey.shade300,
        child: const Icon(Icons.broken_image, size: 80),
      ),
    );
  }

  Widget _buildDetail() {
    final about = event.about ?? [];
    final requirements = event.requirements ?? [];
    final benefits = event.benefits ?? [];
    final positions = event.positions ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 15),

        const Text(
          "Activity Details",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            const Icon(Icons.date_range, size: 18),
            const SizedBox(width: 5),
            Text(event.date ?? "-"),
          ],
        ),

        const SizedBox(height: 5),

        Row(
          children: [
            const Icon(Icons.pin_drop, size: 18),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                event.location ?? "-",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),
        const Divider(),

        _buildSection("About", about),
        const SizedBox(height: 15),

        _buildSection("Requirements", requirements),
        const SizedBox(height: 15),

        _buildSection("Benefits", benefits),

        const SizedBox(height: 20),
        const Divider(),

        const Text(
          "Volunteer Position & Job Description",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(positions.length, (index) {
            final role = positions[index];
            final title = role["title"] ?? "-";
            final points = List<String>.from(role["points"] ?? []);

            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: buildVolunteerRoleWithPoints(
                number: index + 1,
                title: title,
                points: points,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 6),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((x) => Text("• ${x.toString()}")).toList(),
        ),
      ],
    );
  }
}
