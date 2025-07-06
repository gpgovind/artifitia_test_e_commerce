import 'package:artifitia_test_e_commerce/domain/entities/banner.dart';
import 'package:artifitia_test_e_commerce/data/models/banner_dto.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/banner_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseBannerRepositoryImp implements BannerRepository {
  final FirebaseFirestore _firestore;

  FirebaseBannerRepositoryImp(this._firestore);

  @override
  Future<List<BannerModel>> getBanners() async {
    final doc = await _firestore.collection('banners').doc('r8W6zQmmOEcVQO7nDN1F').get();
    final data = doc.data();
    if (data == null) return [];
    return data.entries.map((e) => BannerDto.fromMap(e).toDomain()).toList();
  }

  @override
  Future<List<BannerModel>> getOfferBanners() async {
    final doc = await _firestore.collection('offer_banners').doc('K8OWB68tLcoSRS8GcGtb').get();
    final data = doc.data();
    if (data == null) return [];
    return data.entries.map((e) => BannerDto.fromMap(e).toDomain()).toList();
  }
}
