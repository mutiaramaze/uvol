import 'package:flutter/material.dart';
import 'package:uvol/events.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [Icon(Icons.arrow_back), width(5), Text('Settings')]),
          Column(
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
                  print('Tekan seali');
                },
                child: Text('Keluar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
