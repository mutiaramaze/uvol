import 'package:flutter/material.dart';
import 'package:uvol/view/events.dart';

class QuestioningEvent extends StatefulWidget {
  const QuestioningEvent({super.key});

  @override
  State<QuestioningEvent> createState() => _QuestioningEventState();
}

class _QuestioningEventState extends State<QuestioningEvent> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Kamu berhasil terdaftar! Silahkan tunggu konfirmasi",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xFF4962BF),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Events()),
                      );
                    });
                  },
                  child: const Text(
                    "Kirim",
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
                hintText: "What's on your mind?",
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
