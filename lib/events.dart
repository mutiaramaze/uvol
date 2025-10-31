import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EFF8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Color(0xFF4962BF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    "My Events",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomSlidingSegmentedControl<int>(
                    initialValue: _selectedValue,
                    isStretch: true,
                    children: const {1: Text("Upcoming"), 2: Text("Ongoing")},
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    thumbDecoration: BoxDecoration(
                      color: Color(0xFFA69696),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    onValueChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 40),

                // tampilkan isi sesuai pilihan
                _selectedValue == 1
                    ? const Text("Form Login di sini")
                    : const Text("Form Register di sini"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

SizedBox height(double height) => SizedBox(height: height);
SizedBox width(double width) => SizedBox(width: width);
