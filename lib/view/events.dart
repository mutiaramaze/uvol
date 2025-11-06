import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvol/dummy/detail_events.dart';
import 'package:uvol/widget/container_widget.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  List<Map<String, dynamic>> volunteerEvents = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),
      appBar: AppBar(
        title: Text("My Events", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4962BF),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: volunteerEvents.isEmpty
          ? const Center(child: Text("Belum ada event yang kamu daftar"))
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              padding: const EdgeInsets.all(20),
              itemCount: volunteerEvents.length,
              itemBuilder: (BuildContext context, int index) {
                final event = volunteerEvents[index];
                return HomeWidget(
                  volImage: event['image'] ?? '',
                  titleText: event['titleText'] ?? '',
                  date: event['date'] ?? '',
                  location: event['location'] ?? '',
                );
              },
            ),
    );
  }
}
