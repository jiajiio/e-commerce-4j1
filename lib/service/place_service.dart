import 'package:dio/dio.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/util/util.dart';

class PlaceService {
  final key = '2a8efe79eac3cd945ab7810d3e44c086';
  Future<List<Province>> getProvince() async {
    List<Province> province;
    province = [];
    try {
      final response = await Api.createDio().get(
        'https://api.rajaongkir.com/starter/province',
        options: Options(
          headers: {
            'key': key,
          },
        ),
      );
      if (response.statusCode == 200) {
        final item = response.data;
        final data = item['rajaongkir']['results'];
        final p = data.map<Province>((e) => Province.fromJson(e)).toList();
        province = p;
      } else {}
    } catch (e) {}
    return province;
  }

  Future<List<City>> getCity(int provinceId) async {
    List<City> city;
    city = [];
    try {
      final response = await Api.createDio().get(
        'https://api.rajaongkir.com/starter/city',
        options: Options(
          headers: {
            'key': key,
          },
        ),
        queryParameters: {
          'province': provinceId,
        },
      );
      if (response.statusCode == 200) {
        final item = response.data;
        final data = item['rajaongkir']['results'];
        final c = data.map<City>((e) => City.fromJson(e)).toList();
        city = c;
      } else {}
    } catch (e) {}
    return city;
  }

  Future<CostPrice> getCost({
    required int originId,
    required int destinationId,
    required int weight,
    required String courier,
  }) async {
    CostPrice cost;
    cost = CostPrice(
      code: '',
      name: '',
      costs: [],
    );
    try {
      final response = await Api.createDio().post(
        'https://api.rajaongkir.com/starter/cost',
        options: Options(
          headers: {
            'key': key,
          },
        ),
        data: {
          'origin': originId,
          'destination': destinationId,
          'weight': weight,
          'courier': courier,
        },
      );
      if (response.statusCode == 200) {
        final item = response.data;
        final data = item['rajaongkir']['results'][0];
        final c = CostPrice.fromJson(data);
        cost = c;
      } else {}
    } catch (e) {}
    return cost;
  }
}
