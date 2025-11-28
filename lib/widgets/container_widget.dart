import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uvol/features/sqf/details/detail_events.dart';
import 'package:uvol/features/sqf/main%20page/events.dart';
import 'package:uvol/utils/safe_image.dart';
import 'package:uvol/widgets/app_images.dart';

//forum
class ForumWidget extends StatelessWidget {
  const ForumWidget({
    super.key,

    required this.name,
    required this.time,
    required this.upload,
    required this.like,
    required this.comment,
  });

  final String name;
  final String time;
  final String upload;
  final String like;
  final String comment;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height(5),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(AppImages.ali),
              ),
              width(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(time, style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(upload),

              Divider(color: Colors.grey, thickness: 0.5),

              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    size: 18,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  width(5),
                  Text(like),
                  width(20),
                  Icon(
                    Icons.comment,
                    size: 18,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  width(5),
                  Text(comment),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//events (upcoming dan in review)
class EventsWidget extends StatelessWidget {
  const EventsWidget({
    super.key,
    required this.maintitle,
    required this.leftmonth,
    required this.leftdate,
    required this.time,
    required this.loc,
  });
  final String maintitle;
  final String leftmonth;
  final String leftdate;
  final String time;
  final String loc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 132, 154, 165),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          children: [
            Row(
              children: [
                Text(maintitle, style: TextStyle(color: Colors.white)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.time_to_leave, size: 16),
                    SizedBox(width: 5),
                    Text(time, style: TextStyle(color: Colors.white)),
                  ],
                ),
                Text(leftmonth, style: TextStyle(color: Colors.white)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.pin, size: 16, color: Colors.white),
                    SizedBox(width: 5),
                    Text(loc, style: TextStyle(color: Colors.white)),
                  ],
                ),
                Text(leftdate, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//profil (participated)
class ParticipatedWidget extends StatelessWidget {
  const ParticipatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
        ),
        child: ListTile(
          leading: Image.asset(AppImages.beachcleanup, height: 200),
          title: Text(
            "Beach Cleanup",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.date_range, size: 16, color: Colors.black),
                  width(5),
                  Text("Sat, 12th April"),
                ],
              ),

              Row(
                children: [
                  Icon(Icons.pin_drop, size: 16, color: Colors.black),
                  width(5),
                  Text("Pantai Anyer, Banten"),
                ],
              ),
              height(20),
              GestureDetector(
                child: Positioned(
                  bottom: 8,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4962BF), // warna biru elegan
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.download, color: Colors.white, size: 18),
                        width(5),
                        Text(
                          "Sertifikat",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//home
class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.volImage,
    required this.titleText,
    required this.date,
    required this.location,
    this.onTap,
  });
  final String volImage;
  final String titleText;
  final String date;
  final String location;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    print(volImage);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSafeImage(volImage),

            // ClipRRect(
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(10),
            //     topRight: Radius.circular(10),
            //   ),
            //   child: Image.network(
            //     volImage,
            //     height: 150,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //     errorBuilder: (context, error, stackTrace) {
            //       return Container(
            //         height: 90,
            //         width: 110,
            //         color: Colors.grey.shade300,
            //         child: Icon(Icons.image_not_supported),
            //       );
            //     },
            //   ),
            // ),
            height(5),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  height(5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 16,
                        color: Color(0xFF00509D),
                      ),
                      width(5),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF00509D),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.pin_drop, size: 16, color: Color(0xFF00509D)),
                      width(5),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF00509D),
                        ),
                      ),
                    ],
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

// Widget label(String text) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 6, top: 16),
//     child: Text(text, style: TextStyle(color: Color(0xFF4962BF))),
//   );
// }

class BuildTextField extends StatefulWidget {
  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType keyboardType;

  const BuildTextField({
    super.key,
    this.hintText,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? !isVisible : false,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color(0xFFF5F6FA),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        // suffix icon untuk password
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              )
            : null,
      ),
    );
  }
}

Widget formLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF4962BF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
