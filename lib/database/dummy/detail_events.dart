import 'package:flutter/material.dart';
import 'package:uvol/database/firebase/models/detail_model_firebase.dart';
import 'package:uvol/database/model/events.model.dart';
import 'package:uvol/widgets/app_images.dart';

// final List<Map<String, String>> volunteerEvents = [
//   {
//     'image': AppImages.soi,
//     'titleText': 'Scent of Indonesia',
//     'date': '12-14 DEsember 2025',
//     'location': 'Pasaraya, Blok M, Jakarta Selatan',
//   },
//   {
//     'image': AppImages.v1,
//     'titleText': 'Kegiatan bersama anak-anak Bali',
//     'date': '25-08-2025',
//     'location': 'Denpasar, Bali',
//   },
//   {
//     'image': AppImages.mangrove,
//     'titleText': 'Penanaman mangrove bersama',
//     'date': '30-08-2025',
//     'location': 'Jakarta Utara',
//   },
// ];

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

final List<DetailModelFirebase> detailEvents = [
  // 1. Jakarta Fashion Week 2026
  DetailModelFirebase(
    title: "Jakarta Fashion Week 2026",
    date: "20-26 Oktober 2026",
    location: "Senayan City, Jakarta Pusat",
    category: "Fashion",
    image:
        "https://drive.google.com/file/d/10hp-D1IzBcLfg6-M0y6IMiGBXe0sHEVz/view?usp=sharing",
    about: [
      "Event fashion terbesar di Asia Tenggara.",
      "Relawan akan membantu front desk, backstage, dan pengaturan tamu.",
    ],

    requirements: [
      "Minimal 18 tahun.",
      "Berpakaian rapi & komunikatif.",
      "Siap bekerja shift selama event berlangsung.",
    ],

    benefits: [
      "E-certificate",
      "Makan 1x per shift",
      "Akses khusus backstage",
      "Relasi dengan fashion designer nasional",
    ],

    positions: [
      {
        "title": "Front Desk Assistant",
        "points": ["Check-in tamu undangan.", "Membantu pendaftaran peserta."],
      },
      {
        "title": "Backstage Crew",
        "points": ["Membantu persiapan model.", "Mengatur alur backstage."],
      },
    ],
  ),

  // 2. Ubud Writers & Readers Festival 2026
  DetailModelFirebase(
    title: "Ubud Writers & Readers Festival 2026",
    date: "23-27 September 2026",
    location: "Ubud, Bali",
    category: "Festival",
    image:
        "https://drive.google.com/file/d/1am1htrgahFgzrRlLpiEjFdkGPQOR5kBn/view?usp=sharing",

    about: [
      "Festival literasi terbesar Indonesia.",
      "Melibatkan ratusan penulis dari dalam dan luar negeri.",
    ],

    requirements: [
      "Suka literasi & diskusi budaya.",
      "Minimal 17 tahun.",
      "Komunikatif dan ramah tamu.",
    ],

    benefits: [
      "Networking dengan penulis internasional",
      "Merchandise volunteer",
      "Sertifikat partisipasi",
    ],

    positions: [
      {
        "title": "Stage Assistant",
        "points": [
          "Mendampingi pembicara.",
          "Mengatur alur sesi panel diskusi.",
        ],
      },
      {
        "title": "Registration Crew",
        "points": ["Melayani pendaftaran pengunjung."],
      },
    ],
  ),

  // 3. Pameran Seni Kontemporer 'Nusantara'
  DetailModelFirebase(
    title: "Pameran Seni Kontemporer 'Nusantara'",
    date: "1-30 Juni 2026",
    location: "Museum MACAN, Jakarta Barat",
    category: "Art",
    image:
        "https://drive.google.com/file/d/1jfjxIkOetb-m1gz28t2mlHfywxE2m1ww/view?usp=sharing",

    about: [
      "Pameran seni modern dari seniman seluruh Indonesia.",
      "Relawan membantu informasi pengunjung dan mengawasi galeri.",
    ],

    requirements: ["Tertarik pada dunia seni.", "Usia minimal 17 tahun."],

    benefits: [
      "E-certificate",
      "Akses penuh pameran",
      "Relasi dengan kurator seni",
    ],

    positions: [
      {
        "title": "Gallery Guide",
        "points": [
          "Memberikan informasi karya seni.",
          "Mengawasi area pameran.",
        ],
      },
      {
        "title": "Ticketing",
        "points": ["Mengatur antrian pengunjung.", "Penukaran tiket masuk."],
      },
    ],
  ),

  // 4. Borobudur Marathon 2026
  DetailModelFirebase(
    title: "Borobudur Marathon 2026",
    date: "10 November 2026",
    location: "Magelang, Jawa Tengah",
    category: "Olahraga",
    image:
        "https://drive.google.com/file/d/19e5IFS_3dOySm1ShOIkFf80nVRJ9K7VQ/view?usp=sharing",
    about: [
      "Ajang lari bergengsi internasional.",
      "Relawan membantu logistik & pelari.",
    ],

    requirements: [
      "Sehat fisik.",
      "Usia minimal 17 tahun.",
      "Datang jam 4 pagi.",
    ],

    benefits: [
      "Kaos panitia",
      "Makan pagi",
      "Relasi komunitas pelari",
      "E-certificate",
    ],

    positions: [
      {
        "title": "Water Station Crew",
        "points": [
          "Membagikan air minum.",
          "Menjaga kebersihan area water station.",
        ],
      },
      {
        "title": "Route Marshall",
        "points": ["Memberi arahan pelari.", "Menjaga rute tetap aman."],
      },
    ],
  ),

  // 5. Festival Layang-Layang Internasional
  DetailModelFirebase(
    title: "Festival Layang-Layang Internasional",
    date: "14-15 Juli 2026",
    location: "Pantai Sanur, Bali",
    category: "Festival",
    image:
        "https://drive.google.com/file/d/1Zqv59O6m1rxIeGYbuqdRyxl8lXqB7Mms/view?usp=sharing",
    about: [
      "Festival budaya dengan peserta dari berbagai negara.",
      "Relawan akan membantu area kompetisi & wisatawan.",
    ],

    requirements: ["Siap bekerja outdoor.", "Tidak takut panas."],

    benefits: ["Snack", "Merch festival", "E-certificate"],

    positions: [
      {
        "title": "Competition Crew",
        "points": ["Membantu juri kompetisi."],
      },
      {
        "title": "Visitor Guide",
        "points": ["Mengatur wisatawan ke spot festival."],
      },
    ],
  ),

  // 6. Konser Musik: Suara Alam
  DetailModelFirebase(
    title: "Konser Musik: Suara Alam",
    date: "5 Mei 2026",
    location: "Hutan Pinus Mangunan, Yogyakarta",
    category: "Music",
    image:
        "https://drive.google.com/file/d/1nb_bZhUpmKHr5nm2RYFOqDLYp2yp67RX/view?usp=sharing",
    about: ["Konser outdoor bertema lingkungan."],

    requirements: ["Minimal 17 tahun.", "Siap tugas sampai malam."],

    benefits: ["Makan 1x", "Merchandise konser", "E-certificate"],

    positions: [
      {
        "title": "Stage Assistant",
        "points": ["Mengatur kebutuhan performer."],
      },
      {
        "title": "Entrance Crew",
        "points": ["Memindai tiket pengunjung."],
      },
    ],
  ),

  // 7. Festival Komedi Jakarta (Cleaned Up Image)
  DetailModelFirebase(
    title: "Festival Komedi Jakarta (Cleaned Up Image)",
    date: "28 November 2025",
    location: "Balai Sarbini Jakarta",
    category: "Entertainment",
    image:
        "https://drive.google.com/file/d/1WegMEaZgqfv0gcTbQvth9hkYdNlsYKpr/view?usp=sharing",
    about: ["Festival komedi tahunan dengan line-up komika nasional."],

    requirements: ["Ramah & komunikatif.", "Tidak mudah panik."],

    benefits: ["Merchandise komika", "Snack", "E-certificate"],

    positions: [
      {
        "title": "Gate Staff",
        "points": ["Check-in tiket"],
      },
      {
        "title": "Audience Guide",
        "points": ["Mengatur tempat duduk penonton."],
      },
    ],
  ),

  // 8. Indonesia Digital Summit 2026
  DetailModelFirebase(
    title: "Indonesia Digital Summit 2026",
    date: "8-9 Maret 2026",
    location: "ICE BSD, Tangerang",
    category: "Technology",
    image:
        "https://drive.google.com/file/d/1Za2HARmt3zQt1rR5YXWB7qMBdY_JKxT3/view?usp=sharing",

    about: ["Event teknologi tahunan yang melibatkan startup dan investor."],

    requirements: ["Minimal mahasiswa aktif.", "Tertarik dunia teknologi."],

    benefits: ["Relasi startup", "Makan siang", "E-certificate"],

    positions: [
      {
        "title": "Company Liaison",
        "points": ["Mendampingi perusahaan peserta."],
      },
      {
        "title": "Registration Staff",
        "points": ["Mengelola check-in pengunjung."],
      },
    ],
  ),

  // 9. Tech Startup Pitch Competition
  DetailModelFirebase(
    title: "Tech Startup Pitch Competition",
    date: "17 April 2026",
    location: "Bandung Techno Park",
    category: "Startup",
    image:
        "https://drive.google.com/file/d/1oQsi_98gC0xFvz7hk2trROsXCtTD1Lhl/view?usp=sharing",

    about: ["Kompetisi pitching startup tingkat nasional."],

    requirements: ["Komunikatif", "Tertarik dunia startup"],

    benefits: ["Relasi investor", "Snack", "Certificate"],

    positions: [
      {
        "title": "Pitch Timing Crew",
        "points": ["Mengatur durasi pitching."],
      },
      {
        "title": "Company Assistant",
        "points": ["Membantu persiapan peserta pitching."],
      },
    ],
  ),

  // 10. Scent of Indonesia: The Aroma Expo
  DetailModelFirebase(
    title: "Scent of Indonesia: The Aroma Expo",
    date: "12-14 Desember 2025",
    location: "Pasaraya, Blok M Jakarta Selatan",
    category: "Lifestyle",
    image:
        "https://drive.google.com/file/d/1J_9gS5eKyK7D-UDXx3s2xfmLbcKo21le/view?usp=sharing",

    about: ["Pameran parfum dan wellness terbesar di Indonesia."],

    requirements: ["Ramah", "Minimal 17 tahun"],

    benefits: ["Fee 300k", "Snacks", "E-certificate"],

    positions: [
      {
        "title": "Ticketing",
        "points": ["Redeem tiket"],
      },
      {
        "title": "Usher",
        "points": ["Mengatur antrian pengunjung"],
      },
    ],
  ),
];
