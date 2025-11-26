import 'package:flutter/material.dart';
import 'package:uvol/constant/categories_home.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/dummy/detail_events.dart';
import 'package:uvol/dummy/home_events.dart';
import 'package:uvol/model/user_model.dart';
import 'package:uvol/volunteer/view/detail_events.dart';

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

  @override
  void initState() {
    super.initState();
    _loadUser();
    print(user?.name);
  }

  Future<void> _loadUser() async {
    final data = await DbHelper.getUser();
    setState(() {
      user = data;
    });

    // Debug kalau mau
    print("USER DARI DB: ${user?.name}");
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
                          "Hello,",
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
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 40,
                child: SearchBar(
                  leading: const Icon(Icons.search),
                  hintText: "Search",
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4962BF),
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: AssetImage(AppImages.v3),
                    alignment: Alignment.centerRight,
                    opacity: 0.15,
                    fit: BoxFit.contain,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 5),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "UVOL",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Be Part of Something Bigger!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Temukan kegiatan relawan terbaik untuk menambah pengalamanmu.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            height(18),
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
                        showCheckmark: false,
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
                            selectedCategory = selected ? category : null;
                          });

                          if (selected) {
                            // Navigasi ke halaman berdasarkan kategori
                            switch (category) {
                              case 'Lingkungan':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Lingkungan(),
                                  ),
                                );
                                break;

                              case 'Pendidikan':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Pendidikan(),
                                  ),
                                );
                                break;

                              case 'Sosial':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Sosial(),
                                  ),
                                );
                                break;

                              case 'Kesehatan':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Kesehatan(),
                                  ),
                                );
                                break;

                              case 'Budaya':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Budaya(),
                                  ),
                                );
                                break;

                              default:
                                break;
                            }
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            height(15),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Semua Kegiatan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            height(8),
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
