import 'package:flutter/material.dart';
import 'package:uvol/dummy/detail_events.dart';
import 'package:uvol/view/events.dart';
import 'package:uvol/widget/widget_%20detail.dart';

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
      backgroundColor: Color(0xFFE9EFF8),
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
          DropDownDetail(),
        ],
      ),
    );
  }
}
