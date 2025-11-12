import 'package:flutter/material.dart';
import 'package:uvol/widget/app_images.dart';

final List<Map<String, String>> volunteerEvents = [
  {
    'image': AppImages.soi,
    'titleText': 'Scent of Indonesia',
    'date': '12-14 DEsember 2025',
    'location': 'Pasaraya, Blok M, Jakarta Selatan',
  },
  {
    'image': AppImages.v1,
    'titleText': 'Kegiatan bersama anak-anak Bali',
    'date': '25-08-2025',
    'location': 'Denpasar, Bali',
  },
  {
    'image': AppImages.mangrove,
    'titleText': 'Penanaman mangrove bersama',
    'date': '30-08-2025',
    'location': 'Jakarta Utara',
  },
];

final List<Map<String, dynamic>> volunteerRoles = [
  {
    "title": "Ticketing",
    "points": [
      "Melaksanakan seluruh kegiatan ticketing & redeem gift",
      "Membantu pengunjung dalam membeli & menukar tiket.",
      "Membagikan wristband dan freebies.",
      "Membantu membagikan ID akses kepada media partner, sponsor, dan invitation."
          "Membantu pengunjung dalam penukaran hadiah dari promo & rangkaian kegiatan yang diadakan SOI bersama sponsor.",
    ],
  },
  {
    "title": "Usher & Crowd Control",
    "points": [
      "Menjadi pusat informasi bagi pengunjung dalam mengarahkan antrean di area tertentu (misal: pintu masuk, area tenant, area venue dll).",
      "Mengatur dan menjaga kelancaran pergerakan pengunjung di dalam venue agar tetap teratur.",
      "Bekerja sama dengan tim logistic & maintenance untuk memastikan seluruh kebutuhan teknis dan operasional tenants terpenuhi dengan cepat.",
    ],
  },
  {
    "title": "Safety & Security",
    "points": [
      "Membantu panitia standby ketika loading in. Bertugas pada area pintu masuk, pintu keluar, dan area dalam hall:",
      "Melakukan pengecekan barang bawaan",
      "Menjaga kekondusifan acara",
      "Berkoordinasi dengan tim medis untuk memastikan pengunjung dan area aman.",
    ],
  },
  {
    "title": "Event",
    "points": [
      "Bekerjasama dengan tim Liaison Officer (LO)",
      "Memastikan keberlangsungan acara berjalan lancar..",
      "Time keeping atau memastikan acara running on track berdasarkan rundown.",
    ],
  },
  {
    "title": "Liaison Officer (LO)",
    "points": [
      "Mendampingi dan memenuhi kebutuhan seluruh pengisi acara, seperti musisi, pembicara, dan talent lainnya.",
      "Bekerja sama dengan tim Event untuk memastikan acara berjalan sesuai rencana.",
    ],
  },
  {
    "title": "Consumption",
    "points": [
      "Membantu pendataan, pengambilan, dan pendistribusian makanan dan minuman kepada seluruh panitia dan tenant.",
      "Membantu pendistribusian free product dari sponsor kepada pengunjung di ticket booth.",
    ],
  },
];

final List<String> listRole = [
  "Ticketing",
  "Usher & Crowd Control",
  "Safety & Security",
  "Event",
  "Liasion Officer(LO)",
  "Consumption",
];
