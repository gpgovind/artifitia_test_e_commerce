import 'dart:developer';

import 'package:artifitia_test_e_commerce/data/models/address_model.dart';
import 'package:artifitia_test_e_commerce/domain/entities/address.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/address_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressRepositoryImp implements AddressRepository {
  final FirebaseFirestore _firestore;

  AddressRepositoryImp(this._firestore);

  @override
  Future<Address?> getAddress({required String email}) async {
    try {
      final doc = await _firestore.collection('Address').doc(email).get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        final addressModel = AddressModel.fromJson(data);
        return addressModel.toEntity();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> saveAddress({required Address address}) async {
    try {
      final data = AddressModel(
        email: address.email,
        password: address.password,
        pincode: address.pincode,
        address: address.address,
        city: address.city,
        state: address.state,
        country: address.country,
        bankAccount: address.bankAccount,
        accountHolderName: address.accountHolderName,
        ifscCode: address.ifscCode,
      );

      await _firestore
          .collection('Address')
          .doc(address.email)
          .set(data.toJson(), SetOptions(merge: true));

      return true;
    } catch (e) {
      log("Save address failed: $e");
      return false;
    }
  }
}
