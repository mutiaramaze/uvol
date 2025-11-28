import 'package:flutter/material.dart';
import 'package:uvol/database/dummy/event_question.dart';
import 'package:uvol/database/firebase/service/events_firebase.dart';
import 'package:uvol/database/firebase/models/questionnig_model_firebase.dart';
import 'package:uvol/database/model/events.model.dart';
import 'package:uvol/database/preferences/preference_handler.dart';
import 'package:uvol/features/firebase/details/thanks.dart';
import 'package:uvol/widgets/widget_%20detail.dart';

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

  String? q1;
  String? q2;
  String? q3;

  final TextEditingController q1C = TextEditingController();
  final TextEditingController q2C = TextEditingController();
  final TextEditingController q3C = TextEditingController();

  // 🔥 Ambil posisi dari event yang dipilih
  List<String> get positionList {
    try {
      return widget.event.positions
              ?.map<String>((p) => p["title"].toString())
              .toList() ??
          [];
    } catch (_) {
      return [];
    }
  }

  // 🔥 Ambil pertanyaan dari dummy eventQuestions
  List<String> get questionList {
    return eventQuestions[widget.event.title] ?? [];
  }

  @override
  void initState() {
    super.initState();

    if (questionList.isNotEmpty) {
      q1 = questionList[0];
      q2 = questionList.length > 1 ? questionList[1] : null;
      q3 = questionList.length > 2 ? questionList[2] : null;
    }
  }

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
              // ===================== DROPWDOWN POSISI
              DropDownDetailFirebase(
                selectdivision: "Divisi yang kamu inginkan",
                selectedValue: division1,
                items: positionList,
                onSelect: (val) => setState(() => division1 = val),
              ),
              const SizedBox(height: 16),

              DropDownDetailFirebase(
                selectdivision: "Divisi opsi ke-2 yang kamu inginkan",
                selectedValue: division2,
                items: positionList,
                onSelect: (val) => setState(() => division2 = val),
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 24),

              // ===================== DYNAMIC QUESTIONS =====================
              if (q1 != null) ...[
                Text(
                  q1!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: q1C,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Tulis jawaban kamu...",
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
              ],

              if (q2 != null) ...[
                Text(
                  q2!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: q2C,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Tulis jawaban kamu...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
              ],

              if (q3 != null) ...[
                Text(
                  q3!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: q3C,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Tulis jawaban kamu...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // ===================== BUTTON
              Center(
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4962BF),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ), // Tinggi tombol
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
                        answer1: q1C.text,
                        answer2: q2C.text,
                        answer3: q3C.text,
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
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
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
