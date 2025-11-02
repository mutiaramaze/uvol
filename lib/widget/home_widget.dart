import 'package:flutter/material.dart';
import 'package:uvol/events.dart';
import 'package:uvol/widget/app_images.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.volImage,
    required this.titleText,
    required this.date,
    required this.location,
  });
  final String volImage;
  final String titleText;
  final String date;
  final String location;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              volImage,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),

          height(5),
          Text(
            titleText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.date_range, size: 15, color: Color(0xFF00509D)),
              width(5),
              Text(
                date,
                style: TextStyle(fontSize: 12, color: Color(0xFF00509D)),
              ),
            ],
          ),
          height(5),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.pin_drop, size: 15, color: Color(0xFF00509D)),
                  width(5),
                  Text(
                    location,
                    style: TextStyle(fontSize: 12, color: Color(0xFF00509D)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
