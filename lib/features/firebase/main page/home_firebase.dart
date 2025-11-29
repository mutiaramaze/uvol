import 'package:flutter/material.dart';
import 'package:uvol/database/dummy/data_events.dart';
import 'package:uvol/database/dummy/detail_events.dart';
import 'package:uvol/database/dummy/home_events.dart';
import 'package:uvol/database/firebase/models/detail_model_firebase.dart';
import 'package:uvol/database/firebase/models/user_firebase_model.dart';
import 'package:uvol/database/firebase/service/user_firebase.dart';
import 'package:uvol/database/preferences/preference_handler_firebase.dart';
import 'package:uvol/extensions/drive_image_extension.dart';
import 'package:uvol/features/firebase/details/detail_events_firebase.dart';
import 'package:uvol/widgets/app_images.dart';
import 'package:uvol/widgets/container_widget.dart';
import 'package:uvol/database/model/events.model.dart';

class HomepageFirebase extends StatefulWidget {
  const HomepageFirebase({super.key});

  @override
  State<HomepageFirebase> createState() => _HomepageFirebaseState();
}

class _HomepageFirebaseState extends State<HomepageFirebase> {
  UserFirebaseModel? user;
  String? selectedCategory = "All";

  final TextEditingController searchC = TextEditingController();
  String searchText = "";

  List<EventsModel> filteredEvents = dataEvents;

  @override
  void initState() {
    super.initState();
    _loadUser();

    filteredEvents = dataEvents;
    selectedCategory = "All";
  }

  Future<void> _loadUser() async {
    final savedUser = await PreferenceHandlerFirebase.getFirebaseUser();

    if (savedUser != null) {
      setState(() => user = savedUser);
    }

    final uid = await PreferenceHandlerFirebase.getUserID();

    if (uid == null || uid.isEmpty) {
      print("Homepage: UID tidak ditemukan");
      return;
    }

    final data = await UserFirebaseService.getUser(uid);

    if (data != null) {
      setState(() => user = data);

      await PreferenceHandlerFirebase.saveFirebaseUser(data);
    }
  }

  List<EventsModel> get finalFilteredEvents {
    List<EventsModel> list = filteredEvents;

    if (searchText.isNotEmpty) {
      list = list.where((ev) {
        final title = ev.title?.toLowerCase() ?? "";
        final location = ev.location?.toLowerCase() ?? "";
        return title.contains(searchText) || location.contains(searchText);
      }).toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),
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
                          "${user?.name ?? ''} 👋",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
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
                  controller: searchC,
                  onChanged: (value) {
                    setState(() => searchText = value.toLowerCase().trim());
                  },
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

            height(10),

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
                        label: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        selected: isSelected,

                        backgroundColor: Colors.white,
                        selectedColor: const Color(0xFF4962BF),

                        showCheckmark: false,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                            width: 1.4,
                            color: isSelected
                                ? const Color(0xFF4962BF)
                                : Colors.grey.shade400,
                          ),
                        ),

                        elevation: isSelected ? 3 : 0,
                        pressElevation: 1,

                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              selectedCategory = category;

                              if (category == "All") {
                                filteredEvents =
                                    dataEvents; 
                              } else {
                                filteredEvents = dataEvents
                                    .where(
                                      (ev) =>
                                          ev.category?.toLowerCase() ==
                                          category.toLowerCase(),
                                    )
                                    .toList();
                              }
                            } else {
                              selectedCategory = "All"; 
                              filteredEvents = dataEvents;
                            }
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            height(10),

            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: finalFilteredEvents.length,
              itemBuilder: (context, index) {
                final event = finalFilteredEvents[index];
                print(event.title);
                print(event.image);
                print(event.image?.driveImageUrl);

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: HomeWidget(
                    volImage: event.image?.driveImageUrl ?? "",
                    titleText: event.title ?? "",
                    date: event.date ?? "",
                    location: event.location ?? "",
                    onTap: () {
                      final detailEvent = detailEvents.firstWhere(
                        (d) =>
                            (d.title ?? "").toLowerCase() ==
                            (event.title ?? "").toLowerCase(),

                        orElse: () => DetailModelFirebase(
                          title: event.title ?? "",
                          date: event.date ?? "",
                          location: event.location ?? "",
                          category: event.category ?? "",
                          image: event.image?.driveImageUrl ?? "",
                          about: [],
                          requirements: [],
                          benefits: [],
                          positions: [],
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TapEventsFirebase(event: detailEvent),
                        ),
                      );
                    },
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

SizedBox height(double h) => SizedBox(height: h);
