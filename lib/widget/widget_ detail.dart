import 'package:flutter/material.dart';
import 'package:uvol/dummy/detail_events.dart';
import 'package:uvol/view/detail_events.dart';

Widget buildVolunteerRoleWithPoints({
  required int number,
  required String title,
  required List<String> points,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Judul + nomor
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$number. ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
      // List poin-poin deskripsi
      Padding(
        padding: const EdgeInsets.only(left: 25, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: points
              .map(
                (point) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "• ",
                        style: TextStyle(fontSize: 14, height: 1.5),
                      ),
                      Expanded(
                        child: Text(
                          point,
                          style: const TextStyle(fontSize: 14, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
}

class DropDownDetail extends StatefulWidget {
  const DropDownDetail({super.key, required this.selectdivision});

  final String selectdivision;

  @override
  State<DropDownDetail> createState() => _DropDownState();
}

class _DropDownState extends State<DropDownDetail> {
  final List<String> listRole = [
    'Ticketing',
    'Usher & Crowd Control',
    "Safety & Security",
    'Event',
    'Liasion Officer (LO)',
    'Consumption',
  ];

  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.selectdivision,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          height(8),
          DropdownButton<String>(
            dropdownColor: Colors.white,
            value: dropDownValue,
            hint: Text("Pilih divisi kamu"),
            isExpanded: true,
            items: listRole.map((String val) {
              return DropdownMenuItem(
                value: val,
                child: Text(val, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                dropDownValue = value!;
              });
              print("Dipilih $dropDownValue");
            },
          ),
        ],
      ),
    );
  }
}
