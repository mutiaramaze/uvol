import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpcomingWidget extends StatelessWidget {
  const UpcomingWidget({
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
