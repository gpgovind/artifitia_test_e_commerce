import 'package:flutter/material.dart';

import 'action_btn.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ActionButton(
          icon: Icons.location_on,
          label: 'Nearest Store',
          onTap: () {},
        ),
        const SizedBox(width: 16),
        ActionButton(
          icon: Icons.lock,
          label: 'VIP',
          onTap: () {},
        ),
        const SizedBox(width: 16),
        ActionButton(
          icon: Icons.cached,
          label: 'Return policy',
          onTap: () {},
        ),
      ],
    );
  }
}

class ActionButtonsRow2 extends StatelessWidget {
  const ActionButtonsRow2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActionButton(
            isMini: false,
            icon: Icons.remove_red_eye,
            label: 'View Similar',
            onTap: () {},
          ),
          const SizedBox(width: 16),
          const SizedBox(width: 16),
          ActionButton(
            isMini: false,
            icon: Icons.compare,
            label: 'Add to Compare',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
