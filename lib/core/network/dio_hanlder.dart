import 'dart:developer';

import 'package:artifitia_test_e_commerce/core/config/helper.dart';
import 'package:artifitia_test_e_commerce/data/retrofit/payment_service.dart';
import 'package:dio/dio.dart';


class DioHandler {
  DioHandler._internal();

  static Future<PaymentService> createApiClient(
    ) async {
    String baseUrl = GlobalHelper.baseURL;

    try {
      // final connectivityResult = await Connectivity().checkConnectivity();
      // if (connectivityResult == [ConnectivityResult.none]) {
      //   // AppUtil.toastMessage('no internet connection');
      //   return Future.error('No internet connection');
      // }

      final dioClient = Dio(
        BaseOptions(
          contentType:"application/json",
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(milliseconds: 10000),
        ),
      );

      dioClient.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        options.headers['accept'] = "/";
        // options.headers['Authorization'] =
        //     'Bearer ${dotenv.env['STRIPE_SECRET']}';

        //    final token = await Storage.getValue(Storage.tokenId);

        // if (token != null) {
        //   options.headers['Authorization'] = 'Bearer $token';
        // }

        return handler.next(options);
      }, onError: (error, handler) async {
        log("Error creating Dio client: $error");
        handler.next(error);
      }));

      final client = PaymentService(dioClient, baseUrl: baseUrl);
      return client;
    } catch (error) {
      log("Error creating Dio client: $error");
      rethrow;
    }
  }
}
