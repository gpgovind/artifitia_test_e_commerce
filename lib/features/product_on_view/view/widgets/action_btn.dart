import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isMini;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isMini = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.lightBlue.withOpacity(0.2),
        highlightColor: Colors.lightBlue.withOpacity(0.1),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: isMini ? 12 : 32, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: isMini ? MainAxisSize.min : MainAxisSize.max,
            children: [
              Icon(icon, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
