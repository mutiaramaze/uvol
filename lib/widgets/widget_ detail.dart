import 'package:flutter/material.dart';

Widget buildVolunteerRoleWithPoints({
  required int number,
  required String title,
  required List<String> points,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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

      /// LIST POIN
      Padding(
        padding: const EdgeInsets.only(left: 25, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: points.map((point) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 14, height: 1.5)),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

class DropDownDetailQuestion extends StatefulWidget {
  final String selectdivision;

  /// Data dari parent
  final String? selectedValue;
  final Function(String?)? onSelect;

  const DropDownDetailQuestion({
    super.key,
    required this.selectdivision,
    this.selectedValue,
    this.onSelect,
  });

  @override
  State<DropDownDetailQuestion> createState() => _DropDownState();
}

class _DropDownState extends State<DropDownDetailQuestion> {
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
  void initState() {
    super.initState();
    dropDownValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.selectdivision,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),

          const SizedBox(height: 8), // FIXED

          DropdownButton<String>(
            dropdownColor: Colors.white,
            value: dropDownValue,
            hint: const Text("Pilih divisi kamu"),
            isExpanded: true,

            items: listRole.map((String val) {
              return DropdownMenuItem(
                value: val,
                child: Text(val, style: const TextStyle(color: Colors.black)),
              );
            }).toList(),

            onChanged: (String? value) {
              setState(() {
                dropDownValue = value;
              });

              if (widget.onSelect != null) {
                widget.onSelect!(value);
              }

              print("Dipilih $dropDownValue");
            },
          ),
        ],
      ),
    );
  }
}
