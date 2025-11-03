import 'package:flutter/material.dart';
import 'package:uvol/widget/app_images.dart';

class TapEvents extends StatefulWidget {
  const TapEvents({super.key});

  @override
  State<TapEvents> createState() => _TapEventsState();
}

class _TapEventsState extends State<TapEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AppImages.v3),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text("Garden Volunteering"),
                  Text("Activity Details"),

                  Row(
                    children: [
                      Icon(Icons.time_to_leave),
                      Text("15 - 30 Januari 2026"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.pin),
                      Text(
                        "Dusun Mangkubatu, Desa Rajawali, Kec. Banda Neira, Kab. Maluku Tengah, Maluku",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('About'),
                      Text(
                        'Laut Banda menyimpan cerita, tentang sejarah, tentang budaya, dan tentang makna yang belum sempat kamu temui. Lewat semesta Jelajah Nusantara, kami mengajakmu menulis bab baru. Tentang perjalanan yang memberi arti',
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("Tekan sekali");
                    },
                    child: Text('Daftar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
