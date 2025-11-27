import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/views/starting/views/login_firebase.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> _logout(BuildContext context) async {
    // Hapus semua data login
    await PreferenceHandler.removeLogin();

    // Bersihkan shared preferences agar benar-benar kosong
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    print("User berhasil logout dan data preferences dibersihkan");

    // Navigasi ke login dan hilangkan semua halaman sebelumnya
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginFirebase()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4962BF),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Akun anda",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),

                const Divider(),
                const Text('Beri Masukan'),
                const Divider(),
                const Text('Bantuan dan Pertanyaan Umum'),
                const Divider(),
                const Text('Kebijakan Privasi'),
                const Divider(),
                const Text('Kebijakan Penggunaan'),
                const Divider(),

                // 🔥 TOMBOL LOGOUT FIXED
                ElevatedButton(
                  onPressed: () => _logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text('Keluar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
