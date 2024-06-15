import 'package:dio/dio.dart';
import 'package:java_toys/constant/constant.dart';
import 'package:java_toys/util/util.dart';

class AdminToyService {
  Future<String> addProduct(
    FormData data,
  ) async {
    try {
      final response = await Api.createDio().post(
        '${baseUrl}produk',
        data: data,
      );
      if (response.statusCode == 200) {
        return 'Success';
      }
    } catch (e) {
      return e.toString();
    }
    return '';
  }

  Future<String> updateProduct({
    required int id,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await Api.createDio().put(
        '${baseUrl}produk/$id',
        data: data,
      );
      if (response.statusCode == 200) {
        return 'Success';
      }
    } catch (e) {
      return e.toString();
    }
    return '';
  }

  Future<String> deleteProduct({
    required int id,
  }) async {
    try {
      final response = await Api.createDio().delete(
        '${baseUrl}produk/$id',
      );
      if (response.statusCode == 200) {
        return 'Success';
      }
    } catch (e) {
      return e.toString();
    }
    return '';
  }
}
