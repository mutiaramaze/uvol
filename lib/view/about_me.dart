import 'package:flutter/material.dart';
import 'package:uvol/view/detail_events.dart';
import 'package:uvol/widget/bottom_nav.dart';
import 'package:uvol/widget/move_button.dart';
import 'package:file_picker/file_picker.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController cvController = TextEditingController();
  String? pdfPath;

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        pdfPath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Tentang Saya",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: aboutController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Ceritakan sedikit tentang dirimu...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Bagian ini tidak boleh kosong";
                  }
                  return null;
                },
              ),
              height(20),
              Text(
                "Skill yang Dimiliki",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: skillsController,
                decoration: InputDecoration(
                  hintText: "Misalnya: Mengajar, Public Speaking, Fotografi...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Bagian ini tidak boleh kosong";
                  }
                  return null;
                },
              ),
              height(20),
              Text(
                "CV",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: cvController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Kirimkan CV anda (pdf)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Bagian ini tidak boleh kosong";
                  }
                  return null;
                },
              ),
              height(30),
              Center(
                child: MoveButton(
                  text: "Simpan",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final about = aboutController.text;
                      final skills = skillsController.text;
                      final cv = cvController.text;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNav()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
