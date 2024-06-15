import 'dart:io';

import 'package:dio/dio.dart';
import 'package:java_toys/constant/url_constant.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/util/util.dart';

class ToyService {
  Future<List<Toys>> getToys(String searchParam, {int? productId}) async {
    List<Toys> result = [];
    try {
      final response = await Api.createDio().get(
        '${baseUrl}produk',
        queryParameters: {
          'search': searchParam,
          'id': productId,
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final item = response.data;
        final dynamic data;
        if (productId == null) {
          data = item['data'];
          final toy = data.map<Toys>((e) => Toys.fromJson(e)).toList();
          result = toy;
        } else {
          data = item['data'];
          final toy = Toys.fromJson(data);
          return [toy];
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }
}
