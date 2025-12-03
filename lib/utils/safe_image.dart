import 'package:flutter/material.dart';
import 'package:uvol/extensions/drive_image_extension.dart';

Widget buildSafeImage(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return Container(
      height: 150,
      color: Colors.grey.shade300,
      child: const Icon(Icons.broken_image, size: 60),
    );
  }

  final fixedUrl = imageUrl.driveImageUrl;

  if (fixedUrl.isEmpty) {
    return Container(
      height: 150,
      color: Colors.grey.shade300,
      child: const Icon(Icons.folder_off, size: 60),
    );
  }

  return Image.network(
    fixedUrl,
    height: 150,
    width: double.infinity,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) => Container(
      height: 150,
      color: Colors.grey.shade300,
      child: const Icon(Icons.error, size: 60),
    ),
  );
}
