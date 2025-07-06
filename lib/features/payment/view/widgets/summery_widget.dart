import 'package:flutter/material.dart';

class OrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final String? actionText;
  final VoidCallback? onAction;

  const OrderSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              if (actionText != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onAction,
                  child: Text(
                    actionText!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
