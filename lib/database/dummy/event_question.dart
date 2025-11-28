import 'package:flutter/material.dart';

class DropDownDetailFirebase extends StatelessWidget {
  final String selectdivision;
  final String? selectedValue;
  final Function(String?) onSelect;
  final List<String> items;

  const DropDownDetailFirebase({
    super.key,
    required this.selectdivision,
    required this.selectedValue,
    required this.onSelect,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      value: selectedValue,
      hint: Text(selectdivision),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onSelect,
    );
  }
}

final Map<String, List<String>> eventQuestions = {
  // ======================================================
  // 1. Jakarta Fashion Week 2026
  // ======================================================
  "Jakarta Fashion Week 2026": [
    "Mengapa kamu tertarik menjadi relawan di bidang fashion?",
    "Apa pengalamanmu sebelumnya sebagai Front Desk atau Backstage?",
    "Bagaimana kamu menangani tamu dengan sikap profesional?",
  ],

  // ======================================================
  // 2. Ubud Writers & Readers Festival 2026
  // ======================================================
  "Ubud Writers & Readers Festival 2026": [
    "Mengapa kamu tertarik dengan dunia literasi dan festival ini?",
    "Ceritakan pengalamanmu dalam mengatur acara atau membantu pembicara.",
    "Bagaimana kamu menangani keramaian dengan sopan dan teratur?",
  ],

  // ======================================================
  // 3. Pameran Seni Kontemporer 'Nusantara'
  // ======================================================
  "Pameran Seni Kontemporer 'Nusantara'": [
    "Apa ketertarikanmu pada dunia seni kontemporer?",
    "Pernahkah kamu menjadi gallery guide sebelumnya? Ceritakan.",
    "Bagaimana kamu menjelaskan karya seni kepada pengunjung yang awam?",
  ],

  // ======================================================
  // 4. Borobudur Marathon 2026
  // ======================================================
  "Borobudur Marathon 2026": [
    "Apakah kamu siap bekerja pagi hari dan dalam kondisi ramai?",
    "Pernahkah kamu bertugas dalam event olahraga sebelumnya?",
    "Jika terjadi kondisi darurat di area lari, apa tindakanmu?",
  ],

  // ======================================================
  // 5. Festival Layang-Layang Internasional
  // ======================================================
  "Festival Layang-Layang Internasional": [
    "Mengapa kamu tertarik membantu event outdoor seperti festival ini?",
    "Bagaimana kamu menangani wisatawan asing yang butuh bantuan?",
    "Jika area kompetisi menjadi sangat ramai, apa yang akan kamu lakukan?",
  ],

  // ======================================================
  // 6. Konser Musik: Suara Alam
  // ======================================================
  "Konser Musik: Suara Alam": [
    "Mengapa kamu ingin menjadi relawan di konser outdoor?",
    "Bagaimana kamu menangani performer atau tamu backstage?",
    "Jika ada penonton tidak mematuhi aturan, bagaimana kamu menanganinya?",
  ],

  // ======================================================
  // 7. Festival Komedi Jakarta
  // ======================================================
  "Festival Komedi Jakarta (Cleaned Up Image)": [
    "Apa motivasimu menjadi volunteer di acara komedi?",
    "Pengalaman apa yang kamu miliki sebagai gate staff atau audience guide?",
    "Bagaimana kamu memastikan alur penonton tetap tertib?",
  ],

  // ======================================================
  // 8. Indonesia Digital Summit 2026
  // ======================================================
  "Indonesia Digital Summit 2026": [
    "Apa minat kamu dalam dunia teknologi dan startup?",
    "Pernahkah kamu menjadi pemandu perusahaan atau registrasi peserta?",
    "Bagaimana kamu menangani pengunjung yang terburu-buru atau kurang sabar?",
  ],

  // ======================================================
  // 9. Tech Startup Pitch Competition
  // ======================================================
  "Tech Startup Pitch Competition": [
    "Apa ketertarikanmu pada dunia startup?",
    "Bagaimana kamu menjaga disiplin waktu dalam sebuah presentasi?",
    "Jika peserta membutuhkan bantuan mendadak, apa langkahmu?",
  ],

  // ======================================================
  // 10. Scent of Indonesia: The Aroma Expo
  // ======================================================
  "Scent of Indonesia: The Aroma Expo": [
    "Mengapa kamu ingin menjadi volunteer di event bertema parfum dan wellness?",
    "Ceritakan pengalamanmu sebagai Usher atau Ticketing.",
    "Bagaimana kamu menangani antrian panjang dengan profesional?",
  ],
};
