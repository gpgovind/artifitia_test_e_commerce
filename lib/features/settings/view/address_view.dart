import 'dart:developer';

import 'package:artifitia_test_e_commerce/core/providers/providers.dart';
import 'package:artifitia_test_e_commerce/domain/entities/address.dart';
import 'package:artifitia_test_e_commerce/features/settings/view_model/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/cst_drop_down.dart';
import 'widgets/cst_selection_header.dart';
import 'widgets/cst_textfield.dart';

class AddressView extends ConsumerStatefulWidget {
  const AddressView({super.key});

  @override
  ConsumerState<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends ConsumerState<AddressView> {
  final List<String> stateOptions = [
    'N1 2LL',
    'N2 1AA,',
    'N3 2BB,',
    'N4 3CC,',
  ];

  final List<String> countryOptions = [
    'United Kingdom',
    'India',
    'United States',
    'Canada',
    'Australia',
  ];

  @override
  void initState() {
    super.initState();
_mailAssign();
    Future.microtask(() async {
      final address = await ref.read(getAddressProvider.future);
      if (address != null) {
        assignAddressToControllers(address);
      }
    });
  }

  void assignAddressToControllers(Address address) {
    final controllers = ref.read(addressTextEditingControllerProvider);

   
    controllers[2].text = address.pincode;
    controllers[3].text = address.address;
    controllers[4].text = address.city;
    controllers[5].text = address.bankAccount;
    controllers[6].text = address.accountHolderName;
    controllers[7].text = address.ifscCode;

    ref.read(stateProvider.notifier).state = address.state;
    ref.read(countryProvider.notifier).state = address.country;
  }

  _mailAssign() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final controllers = ref.read(addressTextEditingControllerProvider);
        final sharePref = await ref.read(sharedPrefHelperProvider.future);
        controllers[0].text = sharePref.userEmail ?? "";
         controllers[1].text = '*********';
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllers = ref.watch(addressTextEditingControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.pink[300],
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SectionHeader(title: 'Personal Details'),
            CustomTextField(
              label: 'Email Address',
              isPassword: false,
              controller: controllers[0],
              onChanged: (p0) {},
              keyboardType: TextInputType.emailAddress,
            ),
            CustomTextField(
              label: 'Password',
              isPassword: false,
              controller: controllers[1],
              onChanged: (p0) {},
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Change Password',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            const SectionHeader(title: 'Business Address Details'),
            CustomTextField(
              label: 'Pincode',
              onChanged: (p0) {},
              controller: controllers[2],
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              label: 'Address',
              onChanged: (p0) {},
              controller: controllers[3],
            ),
            CustomTextField(
              label: 'City',
              onChanged: (p0) {},
              controller: controllers[4],
            ),
            CustomDropdown(
              label: 'State',
              value: ref.watch(stateProvider),
              items: stateOptions,
              onChanged: (value) =>
                  ref.read(stateProvider.notifier).state = value ?? "N1 2LL",
            ),
            CustomDropdown(
              label: 'Country',
              value: ref.watch(countryProvider),
              items: countryOptions,
              onChanged: (value) =>
                  ref.read(countryProvider.notifier).state = value ?? 'India',
            ),
            const SectionHeader(title: 'Bank Account Details'),
            CustomTextField(
              label: 'Bank Account Number',
              onChanged: (p0) {},
              controller: controllers[5],
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              label: 'Account Holder\'s Name',
              onChanged: (p0) {},
              controller: controllers[6],
            ),
            CustomTextField(
              label: 'IFSC Code',
              controller: controllers[7],
              onChanged: (p0) {},
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final controllers =
                      ref.read(addressTextEditingControllerProvider);
                  final state = ref.read(stateProvider);
                  final country = ref.read(countryProvider);

                  final address = Address(
                    email: controllers[0].text,
                    password: '***********',
                    pincode: controllers[2].text,
                    address: controllers[3].text,
                    city: controllers[4].text,
                    state: state,
                    country: country,
                    bankAccount: controllers[5].text,
                    accountHolderName: controllers[6].text,
                    ifscCode: controllers[7].text,
                  );
                  ref
                      .read(settingsViewModelProvider.notifier)
                      .saveAddress(address: address);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
