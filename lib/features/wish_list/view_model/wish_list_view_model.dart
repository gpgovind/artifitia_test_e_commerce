import 'package:artifitia_test_e_commerce/core/providers/providers.dart';
import 'package:artifitia_test_e_commerce/core/utils/app_warning.dart';
import 'package:artifitia_test_e_commerce/domain/entities/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'wish_list_view_model.g.dart';

final wishListProvider = StateProvider<List<Product>>((ref) => []);

@riverpod
class WishListViewModel extends _$WishListViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> getWishList() async {
    final repo = ref.read(wishRepoProvider);
    final user = await ref.read(sharedPrefHelperProvider.future);
    final data = await repo.getWishList(email: user.userEmail ?? '');
    ref.read(wishListProvider.notifier).update((_) => data);
  }

  Future<void> addToWishList(String productName) async {
    state = const AsyncLoading();

    try {
      final repo = ref.read(wishRepoProvider);
      final user = await ref.read(sharedPrefHelperProvider.future);

      final isSaved = await repo.saveToWishList(
        email: user.userEmail ?? "",
        productName: productName,
      );

      if (isSaved) {
        state = const AsyncData(null);
        AppWarning.showWarning('Added to cart', false);
      } else {
        state = AsyncError('Failed to save to cart', StackTrace.current);
        AppWarning.showWarning('Failed to save');
      }
    } catch (e, st) {
      state = AsyncError(e, st);
      AppWarning.showWarning('Something went wrong');
    }
  }
}
