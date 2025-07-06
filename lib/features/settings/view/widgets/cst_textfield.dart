import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? value;
  final String? hintText;
  final Function(String) onChanged;
  final bool isPassword;
  final bool obscureText;
  final TextEditingController controller;
  final VoidCallback? onTogglePassword;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    this.value,
    this.hintText,
    required this.onChanged,
    this.isPassword = true,
    this.obscureText = false,
    required this.controller,
    this.onTogglePassword,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          controller: controller,
          enabled: isPassword,
          obscureText: !isPassword ? obscureText : false,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
