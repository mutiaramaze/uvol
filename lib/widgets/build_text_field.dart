import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuildTextFieldAbout extends StatefulWidget {
  final String? hintText;

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const BuildTextFieldAbout({
    super.key,
    this.hintText,

    this.controller,
    this.validator,
  });

  @override
  State<BuildTextFieldAbout> createState() => _BuildTextFieldAboutState();
}

class _BuildTextFieldAboutState extends State<BuildTextFieldAbout> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      maxLines: null,

      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 214, 212, 212),
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
