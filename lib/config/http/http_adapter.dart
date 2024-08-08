import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';

class HttpAdapter {
  static final httpClient = Dio(BaseOptions(baseUrl: Environment.apiUrl));
}
