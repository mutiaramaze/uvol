import 'package:flutter/material.dart';
import 'package:uvol/view/events.dart';
import 'package:uvol/view/register.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Akun'),
                Divider(),
                Text('Beri Masukan'),
                Divider(),
                Text('Bantuan dan Pertanyaan Umum'),
                Divider(),
                Text('Kebijakan Privasi'),
                Divider(),
                Text('Kebijakan Penggunaan'),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                    print('Tekan seali');
                  },
                  child: Text('Keluar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
