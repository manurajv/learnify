import 'package:flutter/material.dart';

class TopImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://example.com/top_image.jpg', // Replace with your actual image URL
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
