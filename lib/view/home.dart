import 'package:flutter/material.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/dummy/home_events.dart';
import 'package:uvol/model/user_model.dart';
import 'package:uvol/view/detail_events.dart';
import 'package:uvol/view/events.dart';
import 'package:uvol/widget/app_images.dart';
import 'package:uvol/widget/container_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  UserModel? user;
  String? selectedCategory;

  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await DbHelper.getUser();
    setState(() => user = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 231, 248),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Color(0xFF4962BF),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "${user?.name ?? ""} 👋",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications, color: Colors.white),
                  ),
                ],
              ),
            ),
            height(10),

            Padding(
              padding: const EdgeInsets.all(15),
              child: SearchBar(leading: Icon(Icons.search), hintText: "Search"),
            ),

            // Center(
            //   child: Container(
            //     padding: EdgeInsets.all(15),
            //     decoration: BoxDecoration(
            //       color: Colors.white.withOpacity(1),
            //       borderRadius: BorderRadius.circular(8),
            //       boxShadow: [],
            //     ),
            //     child: Column(
            //       children: [
            //         Text("Ayo tap-tap untuk menjadi relawan!"),
            //         Icon(Icons.touch_app),
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "UVOL",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text("Be part of", style: TextStyle(fontSize: 15)),
                            Text("Something bigger!"),
                          ],
                        ),
                        Spacer(),
                        Image.asset(AppImages.v3, height: 80),
                      ],
                    ),
                  ],
                ),
              ),
            ),

Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                final bool isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFF4962BF),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xFF4962BF)
                            : Colors.grey.shade400,
                      ),
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory =
                            selected ? category : null;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),

            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: volunteerEvents.length,
              itemBuilder: (BuildContext context, int index) {
                final event = volunteerEvents[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TapEvents()),
                    );
                  },
                  child: HomeWidget(
                    volImage: event['image'] ?? '',
                    titleText: event['titleText'] ?? '',
                    date: event['date'] ?? '',
                    location: event['location'] ?? '',
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
