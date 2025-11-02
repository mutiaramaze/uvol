import 'package:flutter/material.dart';
import 'package:uvol/events.dart';
import 'package:uvol/widget/app_images.dart';
import 'package:uvol/widget/home_widget.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EFF8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF4962BF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back,",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "R Mutiara 👋",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.notifications, color: Colors.white),
                ],
              ),
            ),
            height(10),

            Padding(
              padding: const EdgeInsets.all(10),
              child: SearchBar(leading: Icon(Icons.search)),
            ),
            height(20),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.yellow[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text("UVOL", style: TextStyle(color: Colors.black)),
                          Text("Be part of"),
                          Text("Something bigger!"),
                        ],
                      ),
                      width(8),
                      Image.asset(AppImages.v3, height: 30),
                    ],
                  ),
                ],
              ),
            ),
            height(10),

            height(20),

            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: 0.9,
              ),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return HomeWidget(
                  volImage: AppImages.v1,
                  titleText: 'Perbaikan Manado',
                  date: '20-08-2025',
                  location: 'Manado, Indonesia',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
