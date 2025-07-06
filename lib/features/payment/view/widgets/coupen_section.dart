import 'package:flutter/material.dart';

class CouponSection extends StatelessWidget {
  final VoidCallback? onSelectCoupon;

  const CouponSection({super.key, this.onSelectCoupon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            Icons.local_offer_outlined,
            size: 24,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 12),
          const Text(
            'Apply Coupons',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onSelectCoupon,
            child: const Text(
              'Select',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}