import 'package:flutter/material.dart';
import 'package:uvol/volunteer/view/main%20page/events.dart';
import 'package:uvol/volunteer/view/main%20page/forum.dart';
import 'package:flutter/material.dart';

class MakePostFirebase extends StatefulWidget {
  const MakePostFirebase({super.key});

  @override
  State<MakePostFirebase> createState() => _MakePostFirebaseState();
}

class _MakePostFirebaseState extends State<MakePostFirebase> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 18, color: Color(0xFF4962BF)),
                  ),
                ),
                const Text("Write a post", style: TextStyle(fontSize: 18)),
                TextButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      Navigator.pop(context, _controller.text);
                    }
                  },
                  child: const Text(
                    "Post",
                    style: TextStyle(fontSize: 18, color: Color(0xFF4962BF)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Ayo tanya sesuatu",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
