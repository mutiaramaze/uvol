import 'package:flutter/material.dart';
import 'package:uvol/firebase/models/detail_model_firebase.dart';
import 'package:uvol/model/events.model.dart';
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

final List<DetailModelFirebase> detailEvents = [
  // ============================================================
  // 1. SCENT OF INDONESIA
  // ============================================================
  DetailModelFirebase(
    title: "Scent of Indonesia",
    date: "12 – 14 Desember 2025",
    location: "Pasaraya, Blok M – Jakarta Selatan",
    category: "Festival",
    image: "assets/images/soi.jpg",

    about: [
      "Festival parfum terbesar pertama di Indonesia.",
      "Relawan akan membantu operasional tenant dan crowd area.",
    ],

    requirements: [
      "Minimal usia 17 tahun.",
      "Berkomunikasi dengan baik.",
      "Siap bekerja selama 3 hari penuh.",
    ],

    benefits: [
      "Fee 300.000",
      "Konsumsi 2x sehari",
      "Networking bersama brand parfum nasional",
      "ID Card Volunteer",
      "E-certificate",
    ],

    positions: [
      {
        "title": "Ticketing",
        "points": [
          "Membantu pembelian dan penukaran tiket.",
          "Membagikan wristband dan freebies.",
          "Melakukan redeem hadiah pengunjung.",
        ],
      },
      {
        "title": "Usher & Crowd Control",
        "points": [
          "Mengatur alur antrean.",
          "Mengatur crowd di area venue.",
          "Membantu tenant dan EO saat dibutuhkan.",
        ],
      },
    ],
  ),

  // ============================================================
  // 2. JAKARTA FOOD CARNIVAL
  // ============================================================
  DetailModelFirebase(
    title: "Jakarta Food Carnival",
    date: "4 – 6 Januari 2026",
    location: "GBK Senayan, Jakarta",
    category: "Kuliner",
    image: "assets/images/foodfest.jpg",

    about: [
      "Festival kuliner terbesar awal tahun.",
      "Terdapat lebih dari 100 tenant makanan.",
    ],

    requirements: [
      "Usia minimal 18 tahun.",
      "Ramah dan komunikatif.",
      "Sanggup bekerja dalam tim.",
    ],

    benefits: ["Free meals 3x sehari", "Goodie bag volunteer", "E-certificate"],

    positions: [
      {
        "title": "Food Court Assistant",
        "points": [
          "Mengatur antrean tenant.",
          "Mengarahkan pengunjung ke area makanan.",
        ],
      },
      {
        "title": "Crowd Management",
        "points": [
          "Mengontrol arus pengunjung.",
          "Menjaga area jalan tetap aman.",
        ],
      },
    ],
  ),

  // ============================================================
  // 3. CHARITY RUN 2025
  // ============================================================
  DetailModelFirebase(
    title: "Charity Run 2025",
    date: "20 Februari 2026",
    location: "Ancol, Jakarta Utara",
    category: "Olahraga",
    image: "assets/images/run.jpg",

    about: ["Charity Run tahunan yang mendukung kesehatan anak Indonesia."],

    requirements: [
      "Usia minimal 17 tahun.",
      "Sehat fisik.",
      "Bersedia datang jam 5 pagi.",
    ],

    benefits: [
      "Kaos panitia",
      "Lunch box",
      "Relasi dengan atlet profesional",
      "E-certificate",
    ],

    positions: [
      {
        "title": "Water Station Crew",
        "points": [
          "Membagikan air minum ke pelari.",
          "Merapikan area water station.",
        ],
      },
      {
        "title": "Finish Line Support",
        "points": ["Membagikan medali.", "Mendampingi peserta yang kelelahan."],
      },
    ],
  ),

  // ============================================================
  // 4. MUSIC VIBES FEST
  // ============================================================
  DetailModelFirebase(
    title: "Music Vibes Fest",
    date: "10 – 12 Maret 2026",
    location: "Beach City International Stadium, Ancol",
    category: "Music",
    image: "assets/images/musicfest.jpg",

    about: [
      "Festival musik dengan lebih dari 20 performer internasional.",
      "Relawan membantu backstage & entrance gate.",
    ],

    requirements: [
      "Usia minimal 18 tahun.",
      "Mampu bekerja di keramaian.",
      "Tidak memiliki fobia suara bising.",
    ],

    benefits: [
      "Akses behind the stage",
      "Merchandise",
      "Konsumsi",
      "E-certificate",
    ],

    positions: [
      {
        "title": "Gate Crew",
        "points": ["Memindai tiket pengunjung.", "Mengatur alur masuk venue."],
      },
      {
        "title": "Artist Runner",
        "points": ["Mengantar kebutuhan artis.", "Berkoordinasi dengan LO."],
      },
    ],
  ),

  // ============================================================
  // 5. TECH CAREER FAIR
  // ============================================================
  DetailModelFirebase(
    title: "Tech Career Fair",
    date: "1 April 2026",
    location: "ICE BSD Hall 3",
    category: "Career",
    image: "assets/images/careerfair.jpg",

    about: [
      "Pameran karier untuk industri teknologi.",
      "Relawan bertugas sebagai LO perusahaan.",
    ],

    requirements: [
      "Minimal semester 3.",
      "Komunikatif.",
      "Berpenampilan rapi.",
    ],

    benefits: ["Relasi HRD nasional", "Lunch", "Certificate"],

    positions: [
      {
        "title": "Company Liaison",
        "points": ["Mendampingi HR perusahaan.", "Mengatur jadwal presentasi."],
      },
      {
        "title": "Registration Staff",
        "points": ["Check-in peserta event.", "Membagikan ID Card."],
      },
    ],
  ),

  // ============================================================
  // 6. CLEAN UP BEACH DAY
  // ============================================================
  DetailModelFirebase(
    title: "Clean Up Beach Day",
    date: "13 April 2026",
    location: "Pantai Indah Kapuk, Jakarta",
    category: "Community",
    image: "assets/images/beach.jpg",

    about: ["Aksi bersih-bersih pantai terbesar di Jakarta."],

    requirements: ["Tidak alergi panas.", "Usia minimal 15 tahun."],

    benefits: ["Snack", "Gloves & tools", "E-certificate"],

    positions: [
      {
        "title": "Waste Sorting",
        "points": ["Memilah sampah organik dan anorganik."],
      },
      {
        "title": "Logistic Helper",
        "points": ["Membantu distribusi alat kebersihan."],
      },
    ],
  ),

  // ============================================================
  // 7. STARTUP EXPO
  // ============================================================
  DetailModelFirebase(
    title: "Startup Expo 2026",
    date: "22 Mei 2026",
    location: "JCC Senayan",
    category: "Business",
    image: "assets/images/startup.jpg",

    about: ["Pameran startup terbesar di Asia Tenggara."],

    requirements: ["Umur minimal 18.", "Komunikatif."],

    benefits: ["Snack", "E-certificate"],

    positions: [
      {
        "title": "Exhibitor Assistant",
        "points": ["Membantu booth startup."],
      },
      {
        "title": "Crowd Guide",
        "points": ["Mengatur rute pengunjung."],
      },
    ],
  ),

  // ============================================================
  // 8. BOOK & ART FAIR
  // ============================================================
  DetailModelFirebase(
    title: "Book & Art Fair",
    date: "2 Juni 2026",
    location: "Kota Tua, Jakarta",
    category: "Festival",
    image: "assets/images/bookfair.jpg",

    about: ["Festival buku dan seni dengan workshop kreatif."],

    requirements: ["Ramah", "Suka dunia seni & literasi"],

    benefits: ["Free workshop access", "Goodie bag", "Certificate"],

    positions: [
      {
        "title": "Workshop Assistant",
        "points": ["Membantu pengunjung workshop."],
      },
      {
        "title": "Exhibition Helper",
        "points": ["Membantu kurator pameran seni."],
      },
    ],
  ),

  // ============================================================
  // 9. NATIONAL YOUTH CAMP
  // ============================================================
  DetailModelFirebase(
    title: "National Youth Camp 2026",
    date: "10 Juli 2026",
    location: "Cibubur, Jakarta Timur",
    category: "Education",
    image: "assets/images/youthcamp.jpg",

    about: ["Camp nasional untuk pelajar SMA & Mahasiswa."],

    requirements: ["Suka aktivitas outdoor.", "Siap menginap 2 hari."],

    benefits: ["Makan 3x sehari", "Kaos camp", "Sertifikat"],

    positions: [
      {
        "title": "Mentor Assistant",
        "points": ["Mendampingi peserta kelompok."],
      },
      {
        "title": "Logistic Staff",
        "points": ["Mengurus barang kebutuhan camp."],
      },
    ],
  ),

  // ============================================================
  // 10. HEALTH CHECKUP DRIVE
  // ============================================================
  DetailModelFirebase(
    title: "Health Checkup Drive",
    date: "5 Agustus 2026",
    location: "Puskesmas Tanah Abang",
    category: "Community",
    image: "assets/images/health.jpg",

    about: ["Aksi pemeriksaan kesehatan gratis untuk warga."],

    requirements: [
      "Minimal D3 keperawatan (untuk medis)",
      "Non-medis boleh ikut sebagai volunteer umum",
    ],

    benefits: ["Snack", "Relasi tenaga medis", "Sertifikat"],

    positions: [
      {
        "title": "Medical Assistant",
        "points": ["Mendampingi perawat melakukan cek kesehatan."],
      },
      {
        "title": "Queue Manager",
        "points": ["Mengatur antrean pasien."],
      },
    ],
  ),
];
