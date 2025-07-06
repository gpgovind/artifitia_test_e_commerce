import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedSizeProvider = StateProvider<String>((ref) => '');
final productCarouselCurrentIndexProvider = StateProvider<int>((ref) => 0);
