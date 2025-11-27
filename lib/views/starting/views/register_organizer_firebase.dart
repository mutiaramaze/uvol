import 'package:flutter/material.dart';
import 'package:uvol/admin/homepage.dart';
import 'package:uvol/volunteer/view/detail_events.dart';
import 'package:uvol/widget/container_widget.dart';

class RegisterOrganizer extends StatefulWidget {
  const RegisterOrganizer({super.key});

  @override
  State<RegisterOrganizer> createState() => _RegisterOrganizerState();
}

class _RegisterOrganizerState extends State<RegisterOrganizer> {
  // Controllers
  final orgNameController = TextEditingController();
  final picNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final descController = TextEditingController();
  final passwordController = TextEditingController();

  String? selectedOrgType;

  final _formKey = GlobalKey<FormState>();

  final orgTypes = [
    "Komunitas",
    "Organisasi Sosial (NGO)",
    "Kampus / BEM / UKM",
    "Pemerintah / CSR",
  ];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 231, 248),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 221, 231, 248),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: const [
                      Text(
                        "Buat akun penyelenggara event",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E2E5D),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Lengkapi informasi organisasimu",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // FORM CARD
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 6),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      formLabel("Nama Organisasi"),
                      BuildTextField(
                        hintText: "Nama Organisasi",
                        controller: orgNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama organisasi tidak boleh kosong";
                          }
                          return null;
                        },
                      ),

                      formLabel("Nama Penanggung Jawab"),
                      BuildTextField(
                        hintText: "Nama PIC",
                        controller: picNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama PIC tidak boleh kosong";
                          }
                          return null;
                        },
                      ),

                      formLabel("Email Penanggung Jawab"),
                      BuildTextField(
                        hintText: "Masukkan email organisasi kamu",
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email tidak boleh kosong";
                          }
                          return null;
                        },
                      ),

                      formLabel("Nomor Telepon"),
                      BuildTextField(
                        hintText: "08xxxxxxxxxx",
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nomor telepon tidak boleh kosong";
                          }
                          return null;
                        },
                      ),

                      formLabel("Jenis Organisasi"),
                      DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        value: selectedOrgType,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F6FA),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: orgTypes
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => selectedOrgType = value);
                        },
                        validator: (value) =>
                            value == null ? "Pilih jenis organisasi" : null,
                      ),

                      const SizedBox(height: 15),

                      formLabel("Domisili Organisasi"),
                      BuildTextField(
                        hintText: "Contoh: DKI Jakarta",
                        controller: cityController,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Domisili tidak boleh kosong";
                          }
                          return null;
                        },
                      ),

                      formLabel("Deskripsi Organisasi"),
                      BuildTextField(
                        hintText:
                            "Ceritakan tentang organisasi kamu dan fokus kegiatan",
                        controller: descController,
                        maxLines: 4,
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return "Deskripsi tidak boleh kosong";
                          return null;
                        },
                      ),

                      formLabel("Password Akun"),
                      BuildTextField(
                        hintText: "Minimal 6 karakter",
                        controller: passwordController,
                        isPassword: true,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                height(20),
                // BUTTON REGISTER
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrganizerPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4962BF),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Daftar Sekarang",
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
      ),
    );
  }
}
