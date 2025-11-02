import 'package:flutter/material.dart';
import 'package:uvol/events.dart';
import 'package:uvol/widget/app_images.dart';

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
                  Text("UVOL", style: TextStyle(color: Colors.black)),
                  Text("Be part of"),
                  Text("Something bigger!"),
                ],
              ),
            ),

            height(20),

            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: 0.9,
              ),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 231, 231, 231),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.asset(
                          AppImages.v1,
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),

                      height(5),
                      Text(
                        "Perbaikan Manado 2022",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 15,
                            color: Color(0xFF00509D),
                          ),
                          width(5),
                          Text(
                            "27/07/2022 - 05/08/2022",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF00509D),
                            ),
                          ),
                        ],
                      ),
                      height(5),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.pin_drop,
                                size: 15,
                                color: Color(0xFF00509D),
                              ),
                              width(5),
                              Text(
                                "Manado Indonesia",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF00509D),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
