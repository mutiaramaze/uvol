import 'package:flutter/material.dart';
import 'package:uvol/volunteer/view/main%20page/events.dart';
import 'package:uvol/volunteer/view/main%20page/home.dart';
import 'package:uvol/volunteer/view/thanks.dart';
import 'package:uvol/widget/widget_%20detail.dart';

class QuestioningEvent extends StatefulWidget {
  const QuestioningEvent({super.key});

  @override
  State<QuestioningEvent> createState() => _QuestioningEventState();
}

class _QuestioningEventState extends State<QuestioningEvent> {
  final _formKey = GlobalKey<FormState>(); // 🔹 Tambah key form
  final TextEditingController answer1Controller = TextEditingController();
  final TextEditingController answer2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF4962BF),
        title: const Text(
          "Form Pertanyaan",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropDownDetail(selectdivision: "Divisi yang kamu inginkan"),
              const SizedBox(height: 16),

              DropDownDetail(
                selectdivision: "Divisi opsi ke-2 yang kamu inginkan",
              ),
              const SizedBox(height: 16),

              DropDownDetail(
                selectdivision: "Divisi opsi ke-3 yang kamu inginkan",
              ),
              const SizedBox(height: 24),

              const Text(
                "Deskripsikan cara kerja kamu dalam 3 kata",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: answer1Controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Tulis jawaban kamu di sini...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Jawaban tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              const Text(
                "Mengapa Scent of Indonesia harus memilih kamu untuk menjadi bagian dari tim volunteer?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: answer2Controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Tulis jawaban kamu di sini...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Jawaban tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4962BF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Kamu berhasil mengirim jawaban! Tunggu konfirmasi ya!",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Color(0xFF4962BF),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ThanksPage(),
                          ),
                          (route) => false,
                        );
                      });
                    }
                  },
                  child: Text("Simpan", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
