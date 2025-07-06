import 'package:artifitia_test_e_commerce/domain/entities/address.dart';

abstract class AddressRepository {
  Future<Address?> getAddress({
    required String email,
  });

  Future<bool> saveAddress({required Address address});

}
