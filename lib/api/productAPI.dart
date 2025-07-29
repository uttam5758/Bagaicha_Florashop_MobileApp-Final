import 'dart:convert';

import 'package:cybershop/response/productResponse.dart';
import 'package:cybershop/util/url.dart';
import 'package:dio/dio.dart';
import 'package:cybershop/api/httpServices.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


class ProductAPI {
  Future<ProductResponse?> getproduct(String? search) async {
    Future.delayed(const Duration(seconds: 2), () {});
    ProductResponse? productResponse;
    Response response;

    try {
      var dio = Dio();
      // dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "http://www.localhost:5000")).interceptor);
      var url = baseUrl + getProductsUrl;
      response = await dio.get(url, queryParameters: {'keyword': search}
      // ,options: buildCacheOptions(Duration(days: 7))
      );

      if (response.statusCode == 200) {
        productResponse = ProductResponse.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return productResponse;
  }
}
