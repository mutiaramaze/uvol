import 'package:flutter/material.dart';

class MoveButton extends StatelessWidget {
  const MoveButton({
    super.key,
    this.onPressed,
    required this.text,
    this.isLoading,
  });
  final void Function()? onPressed;
  final String text;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF4962BF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
