import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvol/dummy/detail_events.dart';
import 'package:uvol/volunteer/view/detail_events.dart';
import 'package:uvol/widget/app_images.dart';
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFF4962BF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Text(
                  "My Events",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
          ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: volunteerEvents.length,
            itemBuilder: (BuildContext context, int index) {
              final event = volunteerEvents[index];
              HomeWidget(
                volImage: event['image'] ?? '',
                titleText: event['titleText'] ?? '',
                date: event['date'] ?? '',
                location: event['location'] ?? '',
              );
            },
          ),
        ],
      ),
    );
  }
}
