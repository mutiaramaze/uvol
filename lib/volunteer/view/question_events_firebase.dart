import 'package:flutter/material.dart';
import 'package:uvol/firebase/service/events_firebase.dart';
import 'package:uvol/firebase/models/questionnig_model_firebase.dart';
import 'package:uvol/model/events.model.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/volunteer/view/thanks.dart';
import 'package:uvol/widget/widget_%20detail.dart';

class QuestionEventsFirebase extends StatefulWidget {
  final EventsModel event;
  const QuestionEventsFirebase({super.key, required this.event});

  @override
  State<QuestionEventsFirebase> createState() => _QuestioningEventState();
}

class _QuestioningEventState extends State<QuestionEventsFirebase> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController answer1Controller = TextEditingController();
  final TextEditingController answer2Controller = TextEditingController();

  String? division1;
  String? division2;
  String? division3;

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
              /// ================= DIVISION 1
              DropDownDetail(
                selectdivision: "Divisi yang kamu inginkan",
                selectedValue: division1,
                onSelect: (val) {
                  setState(() {
                    division1 = val;
                  });
                },
              ),
              const SizedBox(height: 16),

              /// ================= DIVISION 2
              DropDownDetail(
                selectdivision: "Divisi opsi ke-2 yang kamu inginkan",
                selectedValue: division2,
                onSelect: (val) {
                  setState(() {
                    division2 = val;
                  });
                },
              ),
              const SizedBox(height: 16),

              /// ================= DIVISION 3
              DropDownDetail(
                selectdivision: "Divisi opsi ke-3 yang kamu inginkan",
                selectedValue: division3,
                onSelect: (val) {
                  setState(() {
                    division3 = val;
                  });
                },
              ),

              const SizedBox(height: 24),

              /// ================= ANSWER 1
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
                validator: (value) => value == null || value.isEmpty
                    ? "Jawaban tidak boleh kosong"
                    : null,
              ),

              const SizedBox(height: 20),

              /// ================= ANSWER 2
              const Text(
                "Mengapa event ini harus memilih kamu?",
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
                validator: (value) => value == null || value.isEmpty
                    ? "Jawaban tidak boleh kosong"
                    : null,
              ),

              const SizedBox(height: 30),

              /// ================= BUTTON
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

                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final uid = await PreferenceHandler.getUserID();
                    if (uid == null) return;

                    if (division1 == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Pilih divisi pertama")),
                      );
                      return;
                    }

                    final joinModel = QuestionningModelFirebase(
                      id:
                          widget.event.id ??
                          widget.event.title ??
                          DateTime.now().toString(),
                      title: widget.event.title ?? "",
                      image: widget.event.image ?? "",
                      date: widget.event.date ?? "",
                      location: widget.event.location ?? "",
                      category: widget.event.category ?? "",
                      division1: division1,
                      division2: division2,
                      division3: division3,
                      answer1: answer1Controller.text,
                      answer2: answer2Controller.text,
                    );

                    await JoinEventService.joinEvent(
                      userId: uid,
                      event: joinModel,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Kamu berhasil mendaftar event!"),
                        backgroundColor: Color(0xFF4962BF),
                      ),
                    );

                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const ThanksPage()),
                      );
                    });
                  },

                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
