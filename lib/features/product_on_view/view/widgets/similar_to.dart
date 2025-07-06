import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'action_btn.dart';

class SimilarTo extends StatelessWidget {
  const SimilarTo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          children: [
            Text(
              'Similar To',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            Text(
              '282+ Iteams ',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(width: ResponsiveHelper.getResponsiveWidth(context, 30)),
        ActionButton(
          icon: Icons.filter_list,
          label: 'Filter',
          onTap: () {},
        ),
        const SizedBox(width: 5),
        ActionButton(
          icon: Icons.sort,
          label: 'sort',
          onTap: () {},
        ),
      ],
    );
  }
}
