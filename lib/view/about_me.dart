import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/model/aboutme_model.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/view/detail_events.dart';
import 'package:uvol/widget/bottom_nav.dart';
import 'package:uvol/widget/build_text_field.dart';
import 'package:uvol/widget/move_button.dart';
import 'package:file_picker/file_picker.dart';

class AboutMe extends StatefulWidget {
  AboutMe({super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController cvController = TextEditingController();
  String? pdfPath;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        pdfPath = file.path;
        cvController.text = file.path;
      });
      print('Picked file: ${file.path}');
    } else {
      print('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 221, 231, 248)),
      backgroundColor: Color.fromARGB(255, 221, 231, 248),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Ceritain sedikit tentang kamu yuk!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),

                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Tentang Saya",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      BuildTextFieldAbout(
                        controller: aboutController,
                        hintText: "Ceritakan tentang dirimu...",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bagian ini tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      height(20),
                      Row(
                        children: [
                          Text(
                            "Skill yang Dimiliki",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      BuildTextFieldAbout(
                        controller: skillsController,

                        hintText: "Isi dengan skill kamu yaa",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bagian ini tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      height(20),
                      Row(
                        children: [
                          Text(
                            "CV",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(
                            height: 45,
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                elevation: 1,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: pickFile,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.link,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    pdfPath != null
                                        ? "File dipilih"
                                        : "Pilih file",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (pdfPath != null) ...[
                        SizedBox(height: 8),
                        Text(
                          pdfPath!.split('/').last,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 30),

                Center(
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4962BF),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final aboutme = AboutModel(
                            storyaboutme: aboutController.text,
                            skill: skillsController.text,
                            cv: cvController.text,
                          );

                          await DbHelper.insertAbout(aboutme);
                          Fluttertoast.showToast(msg: "Data anda tersimpan");

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNav(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                height(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildTextFieldAbout2 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  BuildTextFieldAbout2({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        fillColor: Colors.white,
        filled: true,
      ),
      validator: validator,
    );
  }
}
