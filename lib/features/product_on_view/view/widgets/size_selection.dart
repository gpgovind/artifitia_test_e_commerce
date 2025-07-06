import 'package:artifitia_test_e_commerce/domain/entities/product_details.dart';
import 'package:artifitia_test_e_commerce/features/product_on_view/view_model/product_on_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SizeSelector extends ConsumerStatefulWidget {
  final ProductDetails details;
  final Function(String) onSizeSelected;

  const SizeSelector({
    super.key,
    required this.details,
    required this.onSizeSelected,
  });

  @override
  ConsumerState<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends ConsumerState<SizeSelector> {
  @override
  void initState() {
    _initialize();
    super.initState();
  }

  _initialize() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(selectedSizeProvider.notifier).state =
            widget.details.selectedSize;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedSize = ref.watch(selectedSizeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size: $selectedSize',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: widget.details.sizes.map((size) {
            bool isSelected = size == selectedSize;
            return GestureDetector(
              onTap: () {
                ref.read(selectedSizeProvider.notifier).state = size;
                widget.onSizeSelected(size);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.pink : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected ? Colors.pink[50] : Colors.white,
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey[600],
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
