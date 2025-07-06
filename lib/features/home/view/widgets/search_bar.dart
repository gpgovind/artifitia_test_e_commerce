import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class SearchBarNew extends StatelessWidget {
  const SearchBarNew({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveHelper.getResponsiveHeight(context, 50),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search any Product...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: const Icon(Icons.mic, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.grey[100],
          filled: true,
        ),
      ),
    );
  }
}
