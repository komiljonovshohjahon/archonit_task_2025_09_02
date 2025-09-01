import 'package:dio/dio.dart';

class DioClient {
  DioClient({
    required String baseUrl,
    required String apiKey,
  }) : dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           headers: {
             'Authorization': 'Bearer $apiKey',
           },
         ),
       );

  late final Dio dio;
}
