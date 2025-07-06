import 'package:flutter/material.dart';

import 'cash_image.dart';

class CategoryCircle extends StatelessWidget {
  final String name;
  final String image;

  const CategoryCircle({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: CashImage(image: image,),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
