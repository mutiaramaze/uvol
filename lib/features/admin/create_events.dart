import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uvol/widgets/build_text_field.dart';
import 'package:uvol/widgets/container_widget.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final descController = TextEditingController();
  final capacityController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  File? posterImage;

  Future<void> pickPoster() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        posterImage = File(picked.path);
      });
    }
  }

  Future<void> pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: DateTime(today.year + 2),
    );

    if (picked != null) {
      dateController.text = "${picked.day}-${picked.month}-${picked.year}";
    }
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      timeController.text = picked.format(context);
    }
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 231, 248),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 221, 231, 248),
        elevation: 0,
        title: const Text(
          "Buat Event Baru",
          style: TextStyle(color: Color(0xFF2E2E5D)),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // UPLOAD POSTER
              const Text(
                "Poster Event",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4962BF),
                ),
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: pickPoster,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: posterImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.upload_file,
                              size: 40,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text("Upload Poster Event"),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            posterImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 25),

              // FORM INPUT
              formLabel("Nama Event"),
              BuildTextField(
                hintText: "Masukkan nama event",
                controller: nameController,
                validator: (v) {
                  if (v == null || v.isEmpty)
                    return "Nama event tidak boleh kosong";
                  return null;
                },
              ),

              formLabel("Lokasi Event"),
              BuildTextField(
                hintText: "Masukkan lokasi event",
                controller: locationController,
                validator: (v) {
                  if (v == null || v.isEmpty)
                    return "Lokasi tidak boleh kosong";
                  return null;
                },
              ),

              formLabel("Tanggal Event"),
              GestureDetector(
                onTap: pickDate,
                child: AbsorbPointer(
                  child: BuildTextField(
                    hintText: "Pilih tanggal",
                    controller: dateController,
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Tanggal harus diisi";
                      return null;
                    },
                  ),
                ),
              ),

              formLabel("Kapasitas Volunteer"),
              BuildTextField(
                hintText: "contoh: 50",
                controller: capacityController,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty)
                    return "Kapasitas tidak boleh kosong";
                  return null;
                },
              ),

              formLabel("Deskripsi Event"),
              BuildTextField(
                hintText: "Ceritakan detail event...",
                controller: descController,
                maxLines: 4,
                validator: (v) {
                  if (v == null || v.isEmpty)
                    return "Deskripsi tidak boleh kosong";
                  return null;
                },
              ),

              const SizedBox(height: 30),

              // BUTTON SUBMIT
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : submitEvent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4962BF),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Buat Event",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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

  // ===============================
  // SUBMIT FUNCTION
  // ===============================
  void submitEvent() async {
    if (!_formKey.currentState!.validate()) return;

    if (posterImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Poster event harus diupload")),
      );
      return;
    }

    setState(() => loading = true);

    await Future.delayed(const Duration(seconds: 2)); // simulasi API

    setState(() => loading = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Event berhasil dibuat!")));

    Navigator.pop(context);
  }
}
