import 'package:artifitia_test_e_commerce/core/network/dio_hanlder.dart';
import 'package:artifitia_test_e_commerce/core/utils/shared_pref_helper.dart';
import 'package:artifitia_test_e_commerce/data/repositories/address_repository_imp.dart';
import 'package:artifitia_test_e_commerce/data/repositories/auth_repository_imp.dart';
import 'package:artifitia_test_e_commerce/data/repositories/banner_repository_imp.dart';
import 'package:artifitia_test_e_commerce/data/repositories/cart_repository_imp.dart';
import 'package:artifitia_test_e_commerce/data/repositories/firestore_repository_imp.dart';
import 'package:artifitia_test_e_commerce/data/repositories/payment_repository_imp.dart';
import 'package:artifitia_test_e_commerce/data/repositories/product_repository_imp.dart';
import 'package:artifitia_test_e_commerce/data/repositories/wish_list_repository_imp.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/address_repository.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/auth_repository.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/banner_repository.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/cart_repository.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/payment_domain_repositorie.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/product_repository.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/user_firestore_repository.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/wish_list_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final paymentRepositoryProvider =
    FutureProvider<PaymentDomainRepository>((ref) async {
  final apiClient = await DioHandler.createApiClient();
  return PaymentRepository(apiClient);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(FirebaseAuth.instance);
});

final userFirestoreRepoProvider = Provider<UserFirestoreRepository>((ref) {
  return FirestoreRepositoryImpl(FirebaseFirestore.instance);
});

final sharedPrefHelperProvider = FutureProvider<SharedPrefHelper>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return SharedPrefHelper(prefs);
});

final bannerFirestoreRepoProvider = Provider<BannerRepository>((ref) {
  return FirebaseBannerRepositoryImp(FirebaseFirestore.instance);
});

final productFirestoreRepoProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImp(FirebaseFirestore.instance);
});

final cartListRepoProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImp(FirebaseFirestore.instance);
});

final addressRepoProvider = Provider<AddressRepository>((ref) {
  return AddressRepositoryImp(FirebaseFirestore.instance);
});
final wishRepoProvider = Provider<WishListRepository>((ref) {
  return WishListRepositoryImp(FirebaseFirestore.instance);
});
